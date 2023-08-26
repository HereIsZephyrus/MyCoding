clc;close all;clear
loaded_data = load('road_data.mat');
Roaddata_loaded = loaded_data.Roaddata;
n = 2;%求路段n距离
latitude = [Roaddata_loaded(n).latitude];
longitude = [Roaddata_loaded(n).longitude];

displacement=[latitude,longitude];
num_points = size(displacement, 1);

distances_km = zeros(num_points, 1);
for i = 2:num_points
    distances_km(i) = haversine(displacement(i-1, 1), displacement(i-1, 2), displacement(i, 1), displacement(i, 2));
end

distances_mm = distances_km*1000;

%% 可视化 位移与时间关系
figure
plot(distances_mm)

function distance = haversine(lat1, lon1, lat2, lon2)
    R = 6371; % Earth's radius in kilometers
    dLat = deg2rad(lat2 - lat1);
    dLon = deg2rad(lon2 - lon1);
    a = sin(dLat / 2) * sin(dLat / 2) + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    c = 2 * atan2(sqrt(a), sqrt(1 - a));
    distance = R * c; % Distance in kilometers
end
