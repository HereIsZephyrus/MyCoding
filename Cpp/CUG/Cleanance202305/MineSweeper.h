#pragma once
#include "graph.h"

//enum class HardLevel {Primary, Intermediate, Exclusive };// 难度等级
//bool isInitgraph = true;
class MineSweeper : protected Graph{
public:
    MineSweeper(int g_size = static_cast<int>(HardLevel::Primary)) : Graph(g_size){
        curSize = g_size;
        b_win = false;// 玩家是否胜利
        b_dead = false;// 玩家是否死亡
        isStart = false;// 已经交互开始游戏
        isTick = false;// 是否开始计时
        residue = n_size_x * n_size_y - n_mine;// 剩余未点击的格子数
        val_blank = 0;// 标记为空白格子
        val_mine = -1;// 标记为地雷
        val_clicked_blank = -2;// 标记为已点击的空白格子
        val_clicked_num = -11;// 标记为已点击的数字格子
        val_Dflag = -22;// 标记为已经插旗的格子(偏置，并不判断是否正确)
        n_tick = 0;// 计时

        cell = new int* [n_size_x];// 二维数组，存储每个格子的状态
        for (int i = 0; i < n_size_x; ++i){
            cell[i] = new int[n_size_y];
            memset(cell[i], val_blank, n_size_y * sizeof(int));// 初始化为blank
        }

        for (int i = 0; i < n_mine; ++i){//生成地雷
            int x, y;//随机生成地雷的位置
            x = rand() % n_size_x;
            y = rand() % n_size_y;
            if (cell[x][y] != val_mine)
                cell[x][y] = val_mine;
            else{
                int dd = (x * y > n_size_x * n_size_y / 2) ? -1 : 1;//是否落在上三角,向中心移动
                while (cell[x][y] == val_mine){
                    if (x + dd > 0 && x + dd < n_size_x - 1)
                        x += dd;
                    else
                        y += dd;
                }
                cell[x][y] = val_mine;
            }
        }

        for (int y = 0; y < n_size_y; ++y)
            for (int x = 0; x < n_size_x; ++x)
                if (cell[x][y] != val_mine){//计算每个格子周围的地雷数
                    int n = 0;
                    for (int tempX=-1; tempX<=1; ++tempX)
                        for (int tempY=-1; tempY<=1; ++tempY){
                            if (tempX == 0 && tempY == 0)
                                continue;
                            if (x + tempX >= 0 && x + tempX < n_size_x && y + tempY >= 0 && y + tempY < n_size_y && cell[x + tempX][y + tempY] == val_mine)
                                ++n;
                        }
                    if (n == 0)
                        cell[x][y] = val_blank;//周围没有地雷，将不显示数字
                    else
                        cell[x][y] = n;//周围有地雷，显示数字
                }
    }
    int Running();
    int Finish();

protected:
    // 保护成员
    // 设置 img_num
    void SetNum(int val){
        TCHAR valstr[10];
        _stprintf_s(valstr, _T("%d"), val);
        *img_num = *img_blank;
        SetWorkingImage(img_num);
        settextstyle(gap - 1, 0, _T("Consolas"), 0, 0, FW_BLACK, false, false, false);
        settextcolor(COLOR[val - 1]);
        setbkmode(TRANSPARENT);
        outtextxy((gap - 1 - textwidth(valstr)) / 2, (gap - 1 - textheight(valstr)) / 2, valstr);
        SetWorkingImage();
        return;
    }

    // 鼠标在 Face 里
    bool InFace(int x, int y)
    {
        return (x >= faceX && x < faceX + face_w && y >= faceY && y < faceY + face_w) ? true : false;
    }

    // 鼠标在 Map 里
    bool InMap(int x, int y)
    {
        return (x >= left && x < left + n_size_x * gap && y >= top && y < top + n_size_y * gap) ? true : false;
    }

    // 刷新时间
    void FlushTime()
    {
        if (isTick)
        {
            TCHAR tstr[5] = { 0 };
            if (n_tick != 0)
            {
                int t = ((clock() - n_tick) / 1000) > 999 ? 999 : int((clock() - n_tick) / 1000) + 1;
                if (t < 10)
                    _stprintf_s(tstr, _T("00%d"), t);
                else if (t < 100)
                    _stprintf_s(tstr, _T("0%d"), t);
                else if (t < 1000)
                    _stprintf_s(tstr, _T("%d"), t);
                else
                    _stprintf_s(tstr, _T("%d"), 999);
            }
            else
            {
                n_tick = clock();
                _stprintf_s(tstr, _T("00%d"), 1);
            }
            SetWorkingImage(img_Ntime);
            outtextxy((2 * face_w - textwidth(tstr)) / 2, (face_w - textheight(tstr)) / 2, tstr);
            SetWorkingImage();
            putimage(n_timeX, n_timeY, img_Ntime);
        }
    }

    // 显示雷数目
    void ShowMine()
    {
        TCHAR tstr[5] = { 0 };
        if (n_mine < -9)
            _stprintf_s(tstr, _T("%d"), n_mine);
        else if (n_mine < 0)
            _stprintf_s(tstr, _T("0%d"), n_mine);
        else if (n_mine < 10)
            _stprintf_s(tstr, _T("00%d"), n_mine);
        else if (n_mine < 100)
            _stprintf_s(tstr, _T("0%d"), n_mine);
        else
            _stprintf_s(tstr, _T("%d"), n_mine);
        SetWorkingImage(img_Nmine);
        outtextxy((2 * face_w - textwidth(tstr)) / 2, (face_w - textheight(tstr)) / 2, tstr);
        SetWorkingImage();
        putimage(n_mineX, n_mineY, img_Nmine);
    }

    // 显示边缘数字
    void ShowSide()
    {
        for (int y = 0; y < n_size_y; ++y)
            for (int x = 0; x < n_size_x; ++x)
                if (cell[x][y] == val_clicked_blank)
                {
                    POINT arr[8] = { {x - 1, y}, {x - 1, y - 1}, {x, y - 1}, {x + 1, y - 1}, {x + 1, y}, {x + 1, y + 1}, {x, y + 1}, {x - 1, y + 1} };
                    for (int i = 0; i < 8; ++i) {
                        if (arr[i].x >= 0 && arr[i].x < n_size_x && arr[i].y >= 0 && arr[i].y < n_size_y && cell[arr[i].x][arr[i].y] > val_blank) {
                            SetNum(cell[arr[i].x][arr[i].y]);
                            putimage(left + (arr[i].x) * gap, top + arr[i].y * gap, img_num);
                            cell[arr[i].x][arr[i].y] += val_clicked_num;
                            residue--;
                        }
                    }
                }
    }

    // 显示空格
    void ShowBlank(int x, int y)
    {
        if (x >= 0 && y >= 0 && x < n_size_x && y < n_size_y && cell[x][y] == val_blank)
        {
            putimage(left + x * gap, top + y * gap, img_blank);
            cell[x][y] = val_clicked_blank;
            residue--;
        }
        else
            return;
        ShowBlank(x - 1, y);
        ShowBlank(x, y - 1);
        ShowBlank(x + 1, y);
        ShowBlank(x, y + 1);
        ShowBlank(x - 1, y - 1);
        ShowBlank(x + 1, y - 1);
        ShowBlank(x + 1, y + 1);
        ShowBlank(x - 1, y + 1);
    }

    // 点击动作
    void Click(int x, int y){
        if (cell[x][y] == val_mine){
            b_dead = true;
            putimage(left + x * gap, top + y * gap, img_mine_dead);
            cell[x][y] = val_clicked_blank;
            return;
        }
        else if (cell[x][y] == val_blank){
            ShowBlank(x, y);
            ShowSide();
        }
        else if (cell[x][y] > val_blank){
            SetNum(cell[x][y]);
            putimage(left + x * gap, top + y * gap, img_num);
            cell[x][y] += val_clicked_num;
            residue--;
        }
        if (residue <= 0)
            b_win = true;
    }

    // 提示
    void ShowHint(int x, int y)
    {
        bool down = true;
        if (cell[x][y] != val_clicked_blank)
        {
            POINT arr[8] = { {x - 1, y}, {x - 1, y - 1}, {x, y - 1}, {x + 1, y - 1}, {x + 1, y}, {x + 1, y + 1}, {x, y + 1}, {x - 1, y + 1} };
            if (cell[x][y] >= val_mine)
                putimage(left + x * gap, top + y * gap, img_blank);
            for (int i = 0; i < 8; ++i)
            {
                if (arr[i].x >= 0 && arr[i].x < n_size_x && arr[i].y >= 0 && arr[i].y < n_size_y && cell[arr[i].x][arr[i].y] >= val_mine)
                    putimage(left + arr[i].x * gap, top + arr[i].y * gap, img_blank);
            }

            MOUSEMSG msg;
            while (!(GetAsyncKeyState(VK_ESCAPE) & 0x8000))
            {
                if (MouseHit())
                {
                    msg = GetMouseMsg();
                    if (msg.uMsg == WM_LBUTTONUP || msg.uMsg == WM_RBUTTONUP || msg.uMsg == WM_MBUTTONUP)
                    {
                        putimage(faceX, faceY, img_faceSM);
                        if (InMap(msg.x, msg.y) && down)
                        {
                            if (cell[x][y] >= val_mine)
                                putimage(left + x * gap, top + y * gap, img_unClicked);
                            for (int i = 0; i < 8; ++i)
                                if (arr[i].x >= 0 && arr[i].x < n_size_x && arr[i].y >= 0 && arr[i].y < n_size_y && cell[arr[i].x][arr[i].y] >= val_mine)
                                    putimage(left + arr[i].x * gap, top + arr[i].y * gap, img_unClicked);
                            if (cell[x][y] < val_clicked_blank && cell[x][y] - val_clicked_num > val_blank)
                            {
                                int todead = false;
                                int nMine = 0, nFlag = 0;
                                for (int i = 0; i < 8; ++i)
                                    if (arr[i].x >= 0 && arr[i].x < n_size_x && arr[i].y >= 0 && arr[i].y < n_size_y)
                                    {
                                        if (cell[arr[i].x][arr[i].y] == val_mine || cell[arr[i].x][arr[i].y] - val_Dflag == val_mine)
                                            nMine++;
                                        if (cell[arr[i].x][arr[i].y] < val_clicked_blank + val_clicked_num && cell[arr[i].x][arr[i].y] - val_Dflag >= val_mine)
                                        {
                                            nFlag++;
                                            if (cell[arr[i].x][arr[i].y] - val_Dflag != val_mine)
                                                todead = true;
                                        }
                                    }
                                if (nMine == nFlag && !todead)
                                {
                                    for (int i = 0; i < 8; ++i)
                                        if (arr[i].x >= 0 && arr[i].x < n_size_x && arr[i].y >= 0 && arr[i].y < n_size_y)
                                            Click(arr[i].x, arr[i].y);
                                }
                                if (nMine == nFlag && todead)
                                {
                                    b_dead = true;
                                    for (int i = 0; i < 8; ++i)
                                        if (arr[i].x >= 0 && arr[i].x < n_size_x && arr[i].y >= 0 && arr[i].y < n_size_y)
                                        {
                                            if (cell[arr[i].x][arr[i].y] == val_mine)
                                            {
                                                if (!(cell[arr[i].x][arr[i].y] < val_clicked_blank + val_clicked_num && cell[arr[i].x][arr[i].y] - val_Dflag >= val_mine))
                                                {
                                                    putimage(left + arr[i].x * gap, top + arr[i].y * gap, img_mine_dead);
                                                    cell[arr[i].x][arr[i].y] = val_clicked_num;
                                                }
                                            }
                                            else
                                            {
                                                if (cell[arr[i].x][arr[i].y] < val_clicked_blank + val_clicked_num && cell[arr[i].x][arr[i].y] - val_Dflag >= val_mine && cell[arr[i].x][arr[i].y] - val_Dflag != val_mine)
                                                    putimage(left + arr[i].x * gap, top + arr[i].y * gap, img_mine_wrong);
                                                else
                                                    Click(arr[i].x, arr[i].y);
                                            }
                                        }
                                    for (int j = 0; j < n_size_y; j++)
                                        for (int i = 0; i < n_size_x; ++i)
                                            if (cell[i][j] < val_clicked_blank + val_clicked_num && cell[i][j] - val_Dflag >= val_mine && cell[i][j] - val_Dflag != val_mine)
                                                putimage(left + i * gap, top + j * gap, img_mine_wrong);
                                }
                            }
                        }
                        return;
                    }
                    else if (msg.uMsg == WM_MOUSEMOVE)
                    {
                        if (down)
                        {
                            if (cell[x][y] >= val_mine)
                                putimage(left + x * gap, top + y * gap, img_unClicked);
                            for (int i = 0; i < 8; ++i)
                                if (arr[i].x >= 0 && arr[i].x < n_size_x && arr[i].y >= 0 && arr[i].y < n_size_y && cell[arr[i].x][arr[i].y] >= val_mine)
                                    putimage(left + arr[i].x * gap, top + arr[i].y * gap, img_unClicked);
                        }

                        x = (msg.x - left) / gap;
                        y = (msg.y - top) / gap;
                        arr[0] = { x - 1, y };
                        arr[1] = { x - 1, y - 1 };
                        arr[2] = { x, y - 1 };
                        arr[3] = { x + 1, y - 1 };
                        arr[4] = { x + 1, y };
                        arr[5] = { x + 1, y + 1 };
                        arr[6] = { x, y + 1 };
                        arr[7] = { x - 1, y + 1 };

                        if (InMap(msg.x, msg.y))
                        {
                            if (cell[x][y] != val_clicked_blank)
                            {
                                if (cell[x][y] >= val_mine)
                                    putimage(left + x * gap, top + y * gap, img_blank);
                                for (int i = 0; i < 8; ++i)
                                    if (arr[i].x >= 0 && arr[i].x < n_size_x && arr[i].y >= 0 && arr[i].y < n_size_y && cell[arr[i].x][arr[i].y] >= val_mine)
                                        putimage(left + arr[i].x * gap, top + arr[i].y * gap, img_blank);
                            }
                            down = true;
                        }
                        else
                            down = false;
                    }
                }
                FlushTime();
                Sleep(1);
            }
        }
    }

private:
    // 私有成员
    int curSize;
    bool b_win;
    bool b_dead;
    bool isStart;
    bool isTick;
    int residue;
    int val_blank;
    int val_mine;
    int val_clicked_blank;
    int val_clicked_num;
    int val_Dflag;
    long n_tick;
    int** cell;
};

// 运行
int MineSweeper::Running(){
    MOUSEMSG msg;
    while (!(GetAsyncKeyState(VK_ESCAPE) & 0x8000) && !b_win && !b_dead)
    { // 没有按下ESC 没有赢 没有死
        if (MouseHit())
        {
            msg = GetMouseMsg();
            // 鼠标所在格子的坐标
            int lx = (msg.x - left) / gap;
            int ly = (msg.y - top) / gap;
            int downX = -1, downY = -1; // 记录鼠标按下的有效未点击地块坐标,初始未进行点击
            if ((msg.mkLButton || msg.mkMButton) && msg.y >= g_top)
                putimage(faceX, faceY, img_faceAM); // 在窗口的合法范围内转换为AM即即将开雷的表情

            //*记录各类按下状态
            if (msg.uMsg == WM_LBUTTONDOWN || msg.uMsg == WM_LBUTTONDBLCLK || msg.uMsg == WM_RBUTTONDOWN || msg.uMsg == WM_RBUTTONDBLCLK || msg.uMsg == WM_MBUTTONDOWN || msg.uMsg == WM_MBUTTONDBLCLK)
            { // 鼠标按下
                if (msg.y < g_top)
                {                        // 点击在信息栏的范围内，改变窗体
                    int lSize = curSize; // 记录上一次的窗体大小
                    if (msg.x < m_width)
                        curSize = static_cast<int>(HardLevel::Primary);
                    else if (msg.x < m_width * 2)
                        curSize = static_cast<int>(HardLevel::Intermediate);
                    else
                        curSize = static_cast<int>(HardLevel::Exclusive);
                    isInitgraph = (lSize == curSize) ? false : true; // 是否需要重新初始化窗体
                    return curSize;                                  // 返回新的窗体大小
                }
                else if (InFace(msg.x, msg.y) && msg.uMsg == WM_LBUTTONDOWN)
                {                                       // 点击在表情的范围内且按下了鼠标左键
                    putimage(faceX, faceY, img_faceDN); // 切换到DN
                    while (!(GetAsyncKeyState(VK_ESCAPE) & 0x8000))
                    {
                        if (MouseHit())
                        {
                            msg = GetMouseMsg();
                            if (msg.uMsg == WM_LBUTTONUP)
                            {                                        // 鼠标抬起
                                putimage(faceX, faceY, img_faceSM);  // 切换回SM
                                if (InFace(msg.x, msg.y) && isStart) // 点击在表情的范围内且已经开始游戏,则完成了一次点击(无效而已)
                                    return curSize;
                                else // 已经移开或者处于静止就不做处理
                                    break;
                            }
                            else if (InFace(msg.x, msg.y)) // 鼠标移动到表情的范围内
                                putimage(faceX, faceY, img_faceDN);
                            else
                                putimage(faceX, faceY, img_faceSM);
                        }
                        Sleep(1);
                    }
                }
                else if (InMap(msg.x, msg.y) && !msg.mkLButton && !msg.mkMButton && (msg.uMsg == WM_RBUTTONDOWN || msg.uMsg == WM_RBUTTONDBLCLK))
                { // 点击在地图的范围内且按下了鼠标右键
                    if (cell[lx][ly] >= -1)
                    { // 不是雷
                        putimage(left + lx * gap, top + ly * gap, img_flag);
                        cell[lx][ly] += val_Dflag; // 插旗
                        n_mine--;                  // 可标记地雷数减一
                    }
                    else if (cell[lx][ly] <= -11)
                    {                                                             // 插旗了
                        putimage(left + lx * gap, top + ly * gap, img_unClicked); // 取消插旗
                        cell[lx][ly] -= val_Dflag;                                // 取消插旗
                        n_mine++;                                                 // 可标记地雷数加一
                    }
                    isStart = true; // 一次积极的点击
                    ShowMine();
                    continue;
                }
                else if (InMap(msg.x, msg.y) && (msg.mkMButton || msg.mkLButton && msg.mkRButton) && cell[lx][ly] != val_clicked_blank)
                { // 点击在地图的范围内且按下了鼠标中键或者同时按下了鼠标左右键
                    ShowHint(lx, ly);
                    isStart = true;
                    isTick = true;
                    continue;
                }
                else if (InMap(msg.x, msg.y) && msg.mkLButton && !msg.mkRButton && !msg.mkMButton && cell[lx][ly] >= val_mine)
                {                                                               // 点击在地图的范围内且按下了鼠标左键且该格子未被点击
                    downX = lx, downY = ly;                                     // 记录按下的坐标
                    putimage(left + downX * gap, top + downY * gap, img_blank); // 切换为按下的样式
                }

                //*记录各类松开状态
                while (!(GetAsyncKeyState(VK_ESCAPE) & 0x8000) && !b_dead && !b_win)
                {
                    if (MouseHit())
                    {
                        msg = GetMouseMsg();
                        // 鼠标所在格子的坐标
                        int x = (msg.x - left) / gap;
                        int y = (msg.y - top) / gap;
                        if (msg.uMsg == WM_LBUTTONUP || msg.uMsg == WM_RBUTTONUP || msg.uMsg == WM_MBUTTONUP)
                        { // 刷新并不完整的一次点击
                            // 复原
                            putimage(faceX, faceY, img_faceSM);
                            if (downX != -1 && downY != -1)
                            {
                                putimage(left + downX * gap, top + downY * gap, img_unClicked);
                                downX = -1, downY = -1;
                            }
                            if (InMap(msg.x, msg.y) && msg.uMsg == WM_LBUTTONUP)
                            {
                                Click(x, y);
                                isStart = true;
                                isTick = true;
                            }
                            break;
                        }
                        else if (msg.uMsg == WM_LBUTTONDOWN || msg.uMsg == WM_RBUTTONDOWN || msg.uMsg == WM_MBUTTONDOWN)
                        {
                            if (InMap(msg.x, msg.y) && (msg.mkMButton || msg.mkLButton && msg.mkRButton) && cell[x][y] != val_clicked_blank)
                            { // 检视按下点的周围单元格（不是中央格即被翻开的空白格）
                                if (downX != -1 && downY != -1)
                                {
                                    putimage(left + downX * gap, top + downY * gap, img_unClicked); // 复原
                                    downX = -1, downY = -1;
                                }
                                ShowHint(x, y); // 显示周围的雷数
                                isStart = true;
                                isTick = true;
                                break;
                            }
                        }
                        else if (msg.uMsg == WM_MOUSEMOVE){
                            if (InMap(msg.x, msg.y)){
                                if ((msg.mkMButton || msg.mkLButton && msg.mkRButton) && cell[x][y] != val_clicked_blank)
                                { // 在移动中保持检视状态
                                    ShowHint(x, y);
                                    isStart = true;
                                    isTick = true;
                                    break;
                                }
                                else if (msg.mkLButton)
                                { // 在移动中保持按下状态
                                    if (downX != -1 && downY != -1 && !(x == downX && y == downY))
                                        putimage(left + downX * gap, top + downY * gap, img_unClicked);
                                    if (cell[x][y] >= val_mine)
                                    {
                                        putimage(left + x * gap, top + y * gap, img_blank);
                                        downX = x, downY = y;
                                    }
                                }
                            }
                            else if (downX != -1 && downY != -1)
                            {
                                putimage(left + downX * gap, top + downY * gap, img_unClicked);
                                downX = -1, downY = -1;
                            }
                        }
                    }
                    FlushTime();
                    Sleep(1);
                }
            }
        }
        FlushTime();
        Sleep(1);
    }
    return Finish();
}
int MineSweeper::Finish(){
    if (b_dead){
        for (int y = 0; y < n_size_y; ++y)
            for (int x = 0; x < n_size_x; ++x){
                if (cell[x][y] == val_mine)
                    putimage(left + x * gap, top + y * gap, img_mine);//将贴图换成雷
                else if (cell[x][y] < val_clicked_blank + val_clicked_num && cell[x][y] - val_Dflag >= val_mine && cell[x][y] - val_Dflag != val_mine)//标错了雷
                    putimage(left + x * gap, top + y * gap, img_mine_wrong);//将贴图换成错误的雷
            }
        putimage(faceX, faceY, img_faceCR);
    }
    else if (b_win){
        //将所有的雷标注出来
        for (int y = 0; y < n_size_y; ++y)
            for (int x = 0; x < n_size_x; ++x)
                if (cell[x][y] == val_mine)
                    putimage(left + x * gap, top + y * gap, img_flag);
        putimage(faceX, faceY, img_faceSM);
        n_mine = 0;
        ShowMine();//显示剩余雷数
    }

    MOUSEMSG msg;
    while (!(GetAsyncKeyState(VK_ESCAPE) & 0x8000)){
        if (MouseHit()){
            msg = GetMouseMsg();
            if ((msg.uMsg == WM_LBUTTONDOWN || msg.uMsg == WM_RBUTTONDOWN || msg.uMsg == WM_MBUTTONDOWN) && msg.y < g_top){
                int lSize = curSize;
                if (msg.x < m_width)
                    curSize = static_cast<int>(HardLevel::Primary);
                else if (msg.x < m_width * 2)
                    curSize = static_cast<int>(HardLevel::Intermediate);
                else
                    curSize = static_cast<int>(HardLevel::Exclusive);
                isInitgraph = (lSize == curSize) ? false : true;
                return curSize;
            }
            else if (msg.uMsg == WM_LBUTTONDOWN && InFace(msg.x, msg.y)){
                putimage(faceX, faceY, img_faceDN);
                while (!(GetAsyncKeyState(VK_ESCAPE) & 0x8000)){ // Esc是否被按下
                    if (MouseHit()){
                        msg = GetMouseMsg();
                        if (msg.uMsg == WM_LBUTTONUP && InFace(msg.x, msg.y))
                            return curSize;
                        else if (msg.uMsg == WM_LBUTTONUP && !InFace(msg.x, msg.y))
                            break;
                        else if (InFace(msg.x, msg.y))
                            putimage(faceX, faceY, img_faceDN);
                        else if (b_dead)
                            putimage(faceX, faceY, img_faceCR);
                        else
                            putimage(faceX, faceY, img_faceSM);
                    }
                    Sleep(1);
                }
            }
        }
        Sleep(1);
    }
    return 0;
}
