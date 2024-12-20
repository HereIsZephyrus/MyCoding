const parkInfo = [
            ['武昌区', '黄鹤楼公园', '40.6', '1985年'],
            ['江汉区', '中山公园', '32.8', '1929年'],
            ['江岸区', '解放公园', '46', '1953年'],
            ['汉阳区', '月湖公园', '106', '2007年'],
            ['汉阳区', '龟山公园', '35.33', '1986年'],
            ['武昌区', '沙湖公园', '377', '2013年'],
            ['青山区', '园林科普公园', '11.2', '2007年'],
            ['汉阳区', '武汉动物园', '64.66', '1985年'],
            ['汉阳区', '武汉盆景奇石根雕艺术馆', '0.67', '1988年'],
            ['江岸区', '汉口江滩公园', '153.71', '/'],
            ['江岸区', '颐湖公园', '2.69', '2020年'],
            ['江岸区', '堤角公园', '19.89', '2004年'],
            ['江岸区', '张公堤城市森林公园（江岸段）', '48.36', '2016年'],
            ['江岸区', '宝岛公园', '13.46', '1997年'],
            ['江岸区', '汉广海棠公园', '7.16', '2018年'],
            ['江岸区', '百步亭游园', '4.50', '2004年'],
            ['江岸区', '后湖公园', '38.51', '2021年'],
            ['江岸区', '田田广场', '2.80', '2018年'],
            ['江岸区', '武汉市青少年宫', '20.98', '1956年'],
            ['江汉区', '西北湖绿化广场', '24.15', '1999年'],
            ['江汉区', '常青公园', '20.63', '1999年'],
            ['江汉区', '后襄河公园', '16.80', '2007年'],
            ['江汉区', '菱角湖公园', '14.12', '2000年'],
            ['江汉区', '王家墩公园', '12.03', '2015年'],
            ['江汉区', '小南湖公园', '6.86', '1982年'],
            ['江汉区', '龙王庙公园', '1.70', '2005年'],
            ['江汉区', '喷泉公园', '13.09', '1995年'],
            ['硚口区', '张毕湖公园', '117.2', '/'],
            ['硚口区', '竹叶海公园', '63.87', '/'],
            ['硚口区', '张公堤城市森林公园（硚口段）', '57.23', '2013年'],
            ['硚口区', '硚口公园', '3.27', '1957年'],
            ['硚口区', '硚口汉江江滩公园', '136.11', '2020年'],
            ['硚口区', '硚口警察公园', '8.2', '2019年'],
            ['硚口区', '宜家公园', '8.62', '2020年'],
            ['汉阳区', '墨水湖公园', '78.22', '2018年'],
            ['汉阳区', '莲花湖公园', '14.81', '1959年'],
            ['汉阳区', '琴台绿化广场', '14.63', '1984年'],
            ['汉阳区', '汉阳公园', '3.14', '1957年'],
            ['汉阳区', '汉水公园', '12.55', '1996年'],
            ['汉阳区', '汉阳汉江区管江滩公园', '66.8', '2007年'],
            ['汉阳区', '汉阳长江区管江滩公园', '73.97', '2006年'],
            ['汉阳区', '凤凰公园', '46.29', '/'],
            ['汉阳区', '新区公园', '5.38', '2011年'],
            ['汉阳区', '国博水系景观园', '41.68', '2011年'],
            ['汉阳区', '张之洞体育公园', '5.23', '2021年'],
            ['武昌区', '首义广场', '17.99', '2007年'],
            ['武昌区', '洪山广场', '5.16', '1991年'],
            ['武昌区', '紫阳公园', '29.61', '1951年'],
            ['武昌区', '四美塘公园', '19.43', '1997年'],
            ['武昌区', '武昌公园', '2.05', '2008年'],
            ['武昌区', '洪山公园', '3.72', '1996年'],
            ['武昌区', '内沙湖公园', '8.5', '2008年'],
            ['武昌区', '长春观公园', '1.8', '2008年'],
            ['武昌区', '武昌江滩', '109', '2018年'],
            ['武昌区', '楚望台遗址公园', '3.1', '2011年'],
            ['武昌区', '水果湖儿童公园', '1.75', '1987年'],
            ['青山区', '和平公园', '49.40', '1998年'],
            ['青山区', '青山公园', '35.43', '1961年'],
            ['青山区', '白玉公园', '15.55', '1978年'],
            ['青山区', '南干渠游园', '23.72', '1997年'],
            ['青山区', '戴家湖公园', '70.28', '2015年'],
            ['青山区', '青山矶公园', '26.6', '2004年'],
            ['青山区', '青山江滩公园', '158.39', '/'],
            ['青山区', '武丰闸湿地公园', '17.37', '2018年'],
            ['青山区', '天兴洲大桥公园', '6.04', '2011年'],
            ['江夏区', '谭鑫培公园', '21.55', '2008年'],
            ['江夏区', '新世纪公园', '7.49', '2002年'],
            ['江夏区', '江夏市民休闲活动中心', '6.25', '2006年'],
            ['江夏区', '江夏中央大公园', '95.60', '2019年'],
            ['江夏区', '熊廷弼公园', '7.93', '1987年'],
            ['江夏区', '贺胜桥北伐阵亡将士陵园', '2.00', '1929年'],
            ['江夏区', '金港运动公园', '24.60', '2016年'],
            ['跨江汉区、硚口区、东西湖区', '武汉园博园', '213.77', '2015年'],
            ['洪山区', '关山公园', '8.23', '2008年'],
            ['洪山区', '幸福湾公园', '34.41', '2014年'],
            ['洪山区', '杨春湖公园', '84.27', '2014年'],
            ['洪山区', '团结公园', '5.62', '2020年'],
            ['洪山区', '野芷湖公园一期', '10.1', '/'],
            ['洪山区', '巡司河活水公园', '29.80', '/'],
            ['洪山区', '巡司河风情公园', '5.20', '/'],
            ['洪山区', '八坦公园', '4.99', '/'],
            ['洪山区', '巡司河体育公园', '26.10', '/'],
            ['东湖高新区', '韵湖公园', '19.69', '2017年'],
            ['东湖高新区', '西苑公园', '11.02', '2016年'],
            ['东湖高新区', '兰亭公园', '10.27', '2018年'],
            ['东湖高新区', '光谷三路湿地公园', '18.4', '2020年'],
            ['东湖高新区', '光谷鸡公山公园', '22', '2020年'],
            ['东湖高新区', '龙山溪公园', '26.54', '2017年'],
            ['东湖高新区', '花山湿地公园', '14.19', '2017年'],
            ['东湖高新区', '光谷中央生态大走廊', '304.08', '/'],
            ['东湖高新区', '新月溪公园', '48.11', '/'],
            ['东湖高新区', '左岭花卉科普公园', '1.17', '2021年'],
            ['经济技术开发区', '汤湖公园', '35.44', '2004年'],
            ['经济技术开发区', '汤湖文化宫', '10.2', '2014年'],
            ['经济技术开发区', '南太子湖公园', '32.58', '2021年'],
            ['经济技术开发区', '川江池公园', '75.31', '2021年'],
            ['经济技术开发区', '万家湖公园', '53.5', '2019年'],
            ['经济技术开发区', '后官湖公园（经开）', '28.55', '2021年'],
            ['经济技术开发区', '北太子湖公园', '27.3', '2019年'],
            ['经济技术开发区', '朱家山公园', '7.8', '2009年'],
            ['经济技术开发区', '纱帽江滩公园', '13.3', '2010年'],
            ['经济技术开发区', '三角湖公园', '21.1', '2020年'],
            ['经济技术开发区', '马影河滨水公园', '24.67', '2017年'],
            ['经济技术开发区', '坛山湿地公园', '52.5', '2021年'],
            ['经济技术开发区', '薇湖公园', '5.74', '2016年'],
            ['经济技术开发区', '武汉国际体育文化休闲园（足球公园）', '25.73', '2016年'],
            ['东湖风景区', '东湖听涛风景区', '80.37', '1950年'],
            ['东湖风景区', '东湖落雁风景区', '23.43', '2005年'],
            ['东湖风景区', '东湖磨山风景区', '175.92', '1982年'],
            ['东湖风景区', '马鞍山森林公园', '553.81', '1993年'],
            ['东湖风景区', '东湖海洋乐园', '6.29', '2002年'],
            ['东湖风景区', '中科院武汉植物园', '51.67', '1956年'],
            ['东湖风景区', '华侨城湿地公园', '10.46', '2017年'],
            ['东湖风景区', '东湖绿道', '204.33', '2016年'],
            ['东西湖区', '五环广场', '3.70', '2008年'],
            ['东西湖区', '极地海洋公园', '94.13', '2015年'],
            ['东西湖区', '吴家山公园', '8.42', '1987年'],
            ['东西湖区', '金银湖公园', '330.57', '2019年'],
            ['东西湖区', '黄狮海公园', '47.71', '2019年'],
            ['东西湖区', '径河公园', '164.17', '2019年'],
            ['东西湖区', '舵落口江滩公园', '17.36', '2014年'],
            ['东西湖区', '临空港大道带状公园', '94.8', '2021年'],
            ['东西湖区', '常青花园中央公园', '13.01', '2005年'],
            ['东西湖区', '黄塘湖公园', '68.27', '2021年'],
            ['东西湖区', '金银潭公园', '16.53', '2021年'],
            ['东西湖区', '常青花园堤边公园', '12.59', '2000年'],
            ['东西湖区', '金山游园', '6.81', '2004年'],
            ['东西湖区', '码头潭文化遗址公园', '39.7', '2018年'],
            ['东西湖区', '海昌武汉极地海洋世界', '12.68', '/'],
            ['东西湖区', '金银湖国家城市湿地公园', '12.39', '2004年'],
            ['蔡甸区', '蔡甸区江滩公园', '26.17', '2003年'],
            ['蔡甸区', '蔡甸区运铎公园', '13.83', '2020年'],
            ['黄陂区', '二龙潭公园', '12.1', '1982年'],
            ['黄陂区', '滠水公园一期', '21.24', '2014年'],
            ['黄陂区', '滠水公园二期', '7.23', '2017年'],
            ['黄陂区', '双凤亭公园', '4.65', '2010年'],
            ['黄陂区', '定远公园', '19.6', '2018年'],
            ['黄陂区', '前川公园', '21.07', '/'],
            ['新洲区', '新洲人民广场', '9.31', '2002年'],
            ['新洲区', '航天公园', '6.34', '2019年'],
            ['新洲区', '柴泊湖休闲广场', '6.95', '2010年'],
            ['新洲区', '蓝玉项链公园', '110.28', '2022年'],
            ['新洲区', '举水河滩公园', '3.66', '2010年'],
        ];
let Obj = []
parkInfo.forEach(park => {
    Obj.push({
        district: park[0],
        name: park[1],
        area: park[2],
        year: park[3]
    });
});
const jsonData = JSON.stringify(Obj);
console.log(jsonData);