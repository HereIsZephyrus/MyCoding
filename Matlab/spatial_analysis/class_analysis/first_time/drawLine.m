function drawLine(xMax,yMax)
plot([0.5,0.5],[0.5,yMax - 0.5],'-',LineWidth = 1,Color = 'magenta')
plot([xMax - 0.5,xMax - 0.5],[0.5,yMax - 0.5],'-',LineWidth = 1,Color = 'magenta')
plot([0.5,xMax - 0.5],[0.5,0.5],'-',LineWidth = 1,Color = 'magenta')
plot([0.5,xMax - 0.5],[yMax - 0.5,yMax - 0.5],'-',LineWidth = 1,Color = 'magenta')
plot([3.5,3.5],[0.5,yMax - 0.5],'-',LineWidth = 1,Color = 'magenta')
plot([xMax - 3.5,xMax - 3.5],[0.5,yMax - 0.5],'-',LineWidth = 1,Color = 'magenta')
end