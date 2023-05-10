#pragma once
#include <conio.h>
#include <cstdio>
#include <ctime>
#include <graphics.h>

enum class HardLevel { Primary, Intermediate, Exclusive };// 难度等级
static bool isInitgraph = true;// 是否初始化图形界面
//bool isInitgraph = true;

// Graph类
class Graph{
protected:
//--------------界面参数------------------------
    static constexpr double	PI = 3.1415926;
    static constexpr COLORREF cellLT = WHITE;
    static constexpr COLORREF cellRB = DARKGRAY;
    static constexpr COLORREF cellBK = LIGHTGRAY;
    static constexpr COLORREF butTop = RGB(200, 200, 200);
    static constexpr COLORREF COLOR[8] = { RGB(0, 0, 200), RGB(0, 150, 0), RGB(255, 0, 0), RGB(0, 0, 100), RGB(130, 0, 0), RGB(0, 150, 150), RGB(80, 50, 20) };
    static constexpr int gap = 16;//标定雷长宽的单位
    static constexpr int ltRim_w = 3;//界面留白边（左上）宽度
    static constexpr int Rim_w = 6;//边框宽度
    static constexpr int ltrbRim_w = 3;//立体阴影宽度
    static constexpr int g_top = 22;//游戏区域顶部高度
    static constexpr int win_h = 43;
    static constexpr int face_w = 25;
//--------------坐标参数------------------------
    int n_size_x;//雷块横向排布数量
    int n_size_y; // 雷块纵向排布数量
    int n_mine;   // 雷数量
    int g_width;//界面宽度
    int g_height;//界面高度
    int n_mineX, n_mineY;
    int n_timeX, n_timeY;
    int faceX, faceY;
    int left, top, right, button;//核心雷区坐标
    int m_width,m_height;//信息栏坐标
//--------------对象实例------------------------
    IMAGE* img_unClicked;
    IMAGE* img_Nmine, * img_Ntime;
    IMAGE* img_faceSM, * img_faceAM, * img_faceDN, * img_faceCR;
    IMAGE* img_blank;
    IMAGE* img_mine;
    IMAGE* img_mine_dead;
    IMAGE* img_mine_wrong;
    IMAGE* img_flag;
    IMAGE* img_num;
    IMAGE* img_p, * img_i, * img_e;

public:
    void drawSetMenu(int);
    void drawBorder();
    void drawMainBoard();
    void drawCounting();
    void drawBlocks();
    void drawWatchBoard();
    void drawBroder();
    void drawFaces();
    Graph(int g_size = static_cast<int>(HardLevel::Primary)){
        switch (g_size) {
        case static_cast<int>(HardLevel::Primary):
            n_size_x = 9;
            n_size_y = 9;
            n_mine = 10;
            break;
        case static_cast<int>(HardLevel::Intermediate):
            n_size_x = 16;
            n_size_y = 16;
            n_mine = 40;
            break;
        case static_cast<int>(HardLevel::Exclusive):
            n_size_x = 30;
            n_size_y = 16;
            n_mine = 99;
            break;
        }
        g_width = n_size_x * gap + ltRim_w + Rim_w * 2 + ltrbRim_w * 2;                  // 游戏区域宽度
        g_height = n_size_y * gap + ltRim_w + Rim_w * 2 + ltrbRim_w * 2 + g_top + win_h; // 游戏区域高度
        // 核心雷区坐标
        left = ltRim_w + Rim_w + ltrbRim_w;                // 核心雷区左上角坐标
        top = ltRim_w + Rim_w + ltrbRim_w + g_top + win_h; // 核心雷区左上角坐标
        right = g_width - 1 - Rim_w - ltrbRim_w;           // 核心雷区右下角坐标
        button = g_width - 1 - Rim_w - ltrbRim_w;          // 核心雷区右下角坐标
        drawBlocks();
        drawWatchBoard();
        drawSetMenu(g_size);
        if (isInitgraph){
            closegraph();
            initgraph(g_width, g_height, NOMINIMIZE);
        }
        isInitgraph = false;
        cleardevice();
        drawBorder();
        drawMainBoard();
    }

    // 析构函数
    virtual ~Graph(){
        delete img_unClicked;
        delete img_Nmine;
        delete img_Ntime;
        delete img_faceSM;
        delete img_faceAM;
        delete img_faceDN;
        delete img_faceCR;
        delete img_blank;
        delete img_mine;
        delete img_mine_dead;
        delete img_mine_wrong;
        delete img_flag;
        delete img_num;
        delete img_p;
        delete img_i;
        delete img_e;
        if (isInitgraph)
            closegraph();
    }

};
void Graph::drawBorder(){
    setbkcolor(cellRB);                         // 设置背景色
    setlinecolor(butTop);                       // 设置线条颜色
    line(0, 0, g_width - 1, 0);                 // 绘制上边框
    line(0, g_top - 1, g_width - 1, g_top - 1); // 画绘制下边框
    setfillcolor(cellLT);                       // 设置填充色
    solidrectangle(0, 1, g_width - 1, g_top - 2);

    setfillcolor(cellBK); // 设置填充色
    solidrectangle(ltrbRim_w + Rim_w, top - ltrbRim_w - Rim_w, right + ltrbRim_w, top - ltrbRim_w);
    solidrectangle(ltRim_w + Rim_w + 2, g_top + ltRim_w + Rim_w + 2, g_width - 1 - Rim_w - 2, g_top + ltRim_w + Rim_w + 2 + 32);

    setlinecolor(cellLT);
    line(g_width - 1 - Rim_w, g_top + ltRim_w + Rim_w + 2 + 34, g_width - 1 - Rim_w, g_top + ltRim_w + Rim_w);
    line(g_width - 1 - Rim_w - 1, g_top + ltRim_w + Rim_w + 2 + 33, g_width - 1 - Rim_w - 1, g_top + ltRim_w + Rim_w + 1);
    line(g_width - 1 - Rim_w, g_top + ltRim_w + Rim_w + 2 + 34, ltRim_w + Rim_w, g_top + ltRim_w + Rim_w + 2 + 34);
    line(g_width - 1 - Rim_w, g_top + ltRim_w + Rim_w + 2 + 33, ltRim_w + Rim_w + 1, g_top + ltRim_w + Rim_w + 2 + 33);
    return;
}
void Graph::drawMainBoard(){
    setfillcolor(BLACK);
    n_mineX = ltRim_w + Rim_w * 2 + 1;
    n_mineY = g_top + ltRim_w + Rim_w * 2; // 雷数坐标
    n_timeX = g_width - 2 - Rim_w * 2 - face_w * 2, n_timeY = n_mineY;
    faceX = (g_width - 1) / 2 - face_w / 2 + 2, faceY = n_mineY;
    putimage(n_mineX, n_mineY, img_Nmine);
    putimage(n_timeX, n_timeY, img_Ntime);
    putimage(faceX, faceY, img_faceSM);
    setlinecolor(cellLT);
    for (int i = 0; i < ltRim_w; i++){ //
        line(0, g_top + i, g_width - 1, g_top + i);
        line(i, g_top, i, g_height - 1);
    }
    setlinecolor(cellBK);
    for (int i = 0; i < Rim_w; i++)
        rectangle(ltRim_w + i, g_top + ltRim_w + i, g_width - 1 - i, g_height - 1 - i);
    for (int i = 0; i < ltrbRim_w; i++)
    {
        setlinecolor(cellRB);
        line(ltRim_w + Rim_w + i, top - ltrbRim_w + i, g_width - 1 - Rim_w - i, top - ltrbRim_w + i);
        line(ltRim_w + Rim_w + i, top - ltrbRim_w + i, ltRim_w + Rim_w + i, g_height - 1 - Rim_w - i);
        setlinecolor(cellLT);
        line(g_width - 1 - Rim_w - i, g_height - 1 - Rim_w - i, g_width - 1 - Rim_w - i, top - ltrbRim_w + i);
        line(g_width - 1 - Rim_w - i, g_height - 1 - Rim_w - i, ltRim_w + Rim_w + i, g_height - 1 - Rim_w - i);
    }
    for (int j = 0; j < n_size_y; j++)
        for (int i = 0; i < n_size_x; i++)
            putimage(left + i * gap, top + j * gap, img_unClicked);
    return;
}
void Graph::drawBlocks(){
    //未点击方块
    img_unClicked = new IMAGE(gap - 1, gap - 1);
    SetWorkingImage(img_unClicked);
    setbkcolor(cellBK);
    cleardevice();
    setlinecolor(cellLT);
    line(0, 0, gap - 2, 0);
    line(0, 0, 0, gap - 2);
    line(0, 1, gap - 4, 1);
    line(1, 0, 1, gap - 4);
    setlinecolor(cellRB);
    line(gap - 2, gap - 2, gap - 2, 1);
    line(gap - 2, gap - 2, 1, gap - 2);
    img_blank = new IMAGE(gap - 1, gap - 1);
    SetWorkingImage(img_blank);
    setbkcolor(cellBK);
    cleardevice();
    //地雷方块
    img_mine = new IMAGE(gap - 1, gap - 1);
    SetWorkingImage(img_mine);
    setbkcolor(cellBK);
    cleardevice();
    setfillcolor(BLACK);
    solidcircle((gap - 1) / 2, (gap - 1) / 2, (gap - 1) / 2 - 2);
    setfillcolor(WHITE);
    solidcircle((gap - 1) / 3, (gap - 1) / 3, 1);
    //错误点击上的地雷方块
    img_mine_dead = new IMAGE(gap - 1, gap - 1);
    SetWorkingImage(img_mine_dead);
    setbkcolor(RGB(255, 0, 0));
    cleardevice();
    setfillcolor(BLACK);
    solidcircle((gap - 1) / 2, (gap - 1) / 2, (gap - 1) / 2 - 2);
    setfillcolor(WHITE);
    solidcircle((gap - 1) / 3, (gap - 1) / 3, 1);
    //插错旗的方块
    img_mine_wrong = new IMAGE(gap - 1, gap - 1);
    *img_mine_wrong = *img_mine;
    SetWorkingImage(img_mine_wrong);
    setlinecolor(RGB(255, 0, 0));
    line(2, 2, gap - 3, gap - 3);
    line(2, gap - 3, gap - 3, 2);
    //插旗方块
    img_flag = new IMAGE(gap - 1, gap - 1);
    *img_flag = *img_unClicked;
    POINT pot[3] = {{5, (gap - 1) / 4 + 3}, {(gap - 1) / 2 + 2, 2}, {(gap - 1) / 2 + 2, (gap - 1) / 2 + 3}};
    SetWorkingImage(img_flag);
    setfillcolor(RGB(255, 0, 0));
    solidpolygon(pot, 3);
    setlinecolor(BLACK);
    line((gap - 1) / 2 + 1, (gap - 1) / 2 + 3, (gap - 1) / 2 + 1, (gap - 1) / 2 + 5);
    //数字方块
    img_num= new IMAGE(gap - 1, gap - 1);

    SetWorkingImage();
    return;
}
void Graph::drawCounting(){
    TCHAR str[5] = {0};
    img_Nmine = new IMAGE(face_w * 2, face_w); // 计数板对象指针
    SetWorkingImage(img_Nmine);                // 初始化计数板
    settextcolor(RGB(255, 0, 0));
    settextstyle(face_w - 1, 0, _T("Consolas"));
    _stprintf_s(str, _T("0%d"), n_mine);                                               // 显示雷数
    outtextxy((2 * face_w - textwidth(str)) / 2, (face_w - textheight(str)) / 2, str); // 居中显示

    img_Ntime = new IMAGE(face_w * 2, face_w); // 计时板对象指针
    SetWorkingImage(img_Ntime); // 初始化计时板
    settextcolor(RGB(255, 0, 0));
    settextstyle(face_w - 1, 0, _T("Consolas"));
    _stprintf_s(str, _T("00%d"), 0);                                                   // 显示时间000
    outtextxy((2 * face_w - textwidth(str)) / 2, (face_w - textheight(str)) / 2, str); // 居中显示

    SetWorkingImage();
    return;
}
void Graph::drawFaces(){
    img_faceSM = new IMAGE(face_w, face_w); // 表情对象指针:smile
    SetWorkingImage(img_faceSM);
    setbkcolor(cellBK);
    cleardevice();
    setlinecolor(cellLT);
    for (int i = 0; i < 2; i++){
        setlinecolor(cellLT);
        line(i, i, face_w - 1 - i, i);
        line(i, i, i, face_w - 1 - i);
        setlinecolor(cellRB);
        line(face_w - 1 - i, face_w - 1 - i, face_w - 1 - i, i);
        line(face_w - 1 - i, face_w - 1 - i, i, face_w - 1 - i);
    }
    setfillcolor(YELLOW);
    solidcircle(face_w / 2, face_w / 2, face_w / 2 - 4);
    setlinecolor(BLACK);
    circle(face_w / 2, face_w / 2, face_w / 2 - 4);
    setfillcolor(BLACK);
    solidcircle(face_w / 3 + 1, face_w / 3 + 1, 1);
    solidcircle(face_w / 3 * 2 - 1, face_w / 3 + 1, 1);
    arc(face_w / 3, face_w / 3, face_w / 3 * 2, face_w / 3 * 2, -1 * PI / 9 * 8, -1 * PI / 9);

    img_faceAM = new IMAGE(face_w, face_w); // 表情对象指针:amaze
    SetWorkingImage(img_faceAM);
    setbkcolor(cellBK);
    cleardevice();
    setlinecolor(cellLT);
    for (int i = 0; i < 2; i++){
        setlinecolor(cellLT);
        line(i, i, face_w - 1 - i, i);
        line(i, i, i, face_w - 1 - i);
        setlinecolor(cellRB);
        line(face_w - 1 - i, face_w - 1 - i, face_w - 1 - i, i);
        line(face_w - 1 - i, face_w - 1 - i, i, face_w - 1 - i);
    }
    setfillcolor(YELLOW);
    solidcircle(face_w / 2, face_w / 2, face_w / 2 - 4);
    setlinecolor(BLACK);
    circle(face_w / 2, face_w / 2, face_w / 2 - 4);
    setfillcolor(BLACK);
    solidcircle(face_w / 3 + 1, face_w / 3 + 1, 1);
    solidcircle(face_w / 3 * 2 - 1, face_w / 3 + 1, 1);
    circle(face_w / 2, face_w / 3 * 2, 2);

    img_faceDN = new IMAGE(face_w, face_w); // 表情对象指针:danger
    SetWorkingImage(img_faceDN);
    setbkcolor(cellBK);
    cleardevice();
    setlinecolor(cellRB);
    line(0, 0, face_w - 1, 0);
    line(0, 0, 0, face_w - 1);
    line(1, 1, face_w - 1 - 1, 1);
    line(1, 1, 1, face_w - 1 - 1);
    line(face_w - 1, face_w - 1, face_w - 1, 0);
    line(face_w - 1, face_w - 1, 0, face_w - 1);
    setfillcolor(YELLOW);
    solidcircle(face_w / 2, face_w / 2, face_w / 2 - 4);
    setlinecolor(BLACK);
    circle(face_w / 2, face_w / 2, face_w / 2 - 4);
    setfillcolor(BLACK);
    solidcircle(face_w / 3 + 1, face_w / 3 + 1, 1);
    solidcircle(face_w / 3 * 2 - 1, face_w / 3 + 1, 1);
    arc(face_w / 3, face_w / 3, face_w / 3 * 2, face_w / 3 * 2, -1 * PI / 9 * 8, -1 * PI / 9);

    img_faceCR = new IMAGE(face_w, face_w); // 表情对象指针:coolrun
    SetWorkingImage(img_faceCR);
    setbkcolor(cellBK);
    cleardevice();
    setlinecolor(cellLT);
    for (int i = 0; i < 2; i++){
        setlinecolor(cellLT);
        line(i, i, face_w - 1 - i, i);
        line(i, i, i, face_w - 1 - i);
        setlinecolor(cellRB);
        line(face_w - 1 - i, face_w - 1 - i, face_w - 1 - i, i);
        line(face_w - 1 - i, face_w - 1 - i, i, face_w - 1 - i);
    }
    setfillcolor(YELLOW);
    solidcircle(face_w / 2, face_w / 2, face_w / 2 - 4);
    setlinecolor(BLACK);
    circle(face_w / 2, face_w / 2, face_w / 2 - 4);
    setfillcolor(BLACK);
    line(face_w / 3, face_w / 3 - 1, face_w / 3 + 2, face_w / 3 + 1);
    line(face_w / 3, face_w / 3 + 1, face_w / 3 + 2, face_w / 3 - 1);
    line(face_w / 3 * 2 - 2, face_w / 3 - 1, face_w / 3 * 2, face_w / 3 + 1);
    line(face_w / 3 * 2 - 2, face_w / 3 + 1, face_w / 3 * 2, face_w / 3 - 1);
    arc(face_w / 3, face_w / 3 * 2 - 2, face_w / 3 * 2, face_w - 2, PI / 8, PI / 8 * 7);

    SetWorkingImage();
    return;
}
void Graph::drawSetMenu(int x){
    m_width = g_width / 3; // 上方信息栏宽度
    m_height = g_top - 2;  // 上方信息栏高度
    img_p = new IMAGE(m_width, m_height);
    SetWorkingImage(img_p);
    settextcolor(BLACK);
    settextstyle(m_height - 2, 0, _T("Microsoft YaHei UI"));
    SetWorkingImage(img_p); // 绘制初级菜单
    outtextxy((m_width - 1 - textwidth(_T("初级"))) / 2, (m_height - 1 - textheight(_T("初级"))) / 2, _T("初级")); // 居中对齐输出文字
    if (x == static_cast<int>(HardLevel::Primary)){
        setbkcolor(RGB(200, 255, 255));
        setlinecolor(RGB(80, 200, 255));
        cleardevice();//使用当前背景色清空绘图
        rectangle(0, 0, m_width - 1, m_height - 1);
    }
    else{
        setbkcolor(WHITE);
        cleardevice();
    }

    img_i = new IMAGE(m_width, m_height);
    SetWorkingImage(img_i);
    settextcolor(BLACK);
    settextstyle(m_height - 2, 0, _T("Microsoft YaHei UI"));
    SetWorkingImage(img_i); // 绘制中级菜单
    outtextxy((m_width - 1 - textwidth(_T("中级"))) / 2, (m_height - 1 - textheight(_T("中级"))) / 2, _T("中级")); // 居中对齐输出文字
    if (x == static_cast<int>(HardLevel::Intermediate))
    {
        setbkcolor(RGB(200, 255, 255));
        setlinecolor(RGB(80, 200, 255));
        cleardevice();
        rectangle(0, 0, m_width - 1, m_height - 1);
    }
    else
    {
        setbkcolor(WHITE);
        cleardevice();
    }

    img_e = new IMAGE(m_width, m_height);
    SetWorkingImage(img_e);
    settextcolor(BLACK);
    settextstyle(m_height - 2, 0, _T("Microsoft YaHei UI"));
    SetWorkingImage(img_e); // 绘制高级菜单
    outtextxy((m_width - 1 - textwidth(_T("高级"))) / 2, (m_height - 1 - textheight(_T("高级"))) / 2, _T("高级")); // 居中对齐输出文字
    if (x != static_cast<int>(HardLevel::Primary) && x != static_cast<int>(HardLevel::Intermediate))
    {
        setbkcolor(RGB(200, 255, 255));
        setlinecolor(RGB(80, 200, 255));
        cleardevice();
        rectangle(0, 0, m_width - 1, m_height - 1);
    }
    else
    {
        setbkcolor(WHITE);
        cleardevice();
    }
    SetWorkingImage();
    putimage(0, 1, img_p);
    putimage(m_width, 1, img_i);
    putimage(m_width * 2, 1, img_e);

    SetWorkingImage();
    return;
}

void Graph::drawWatchBoard() {
    drawCounting();
    drawFaces();
}