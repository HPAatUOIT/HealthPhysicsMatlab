clf %clears the figure
ground=[1:1000]; %x-axis for our ground
hills=100*sind(ground); % we will use a sin curve for our hills

plot(ground,hills,'color',[0 1 0]) %plot our hills


axis([0 1000 -100 500]) %set our axis windo so it looks nice

hold on %hold on to draw more

plot(90,100,'O','color','r')   %plot our tank as a red O
plot(360+90,100,'O')           %plot plenemy as a tank as a blue O

v=input('projectile velocity  :');  %input projectile velocity

%we will fire at 45 degrees for simplicity

vx=v*cosd(45);   %x component of our velocity
vy=v*sind(45);   %y component of our velocity

                              
% to plot the trajectory we must put x into y(t) to get a function y(x)
% x = vx * t  so  we can put x/vx for t 


y=[-9.8/2*(x/vx).^2 + vy*(x/vx)+100]; % this is the y vector from the function y(x)

xmove=linspace(90,1090,200); %lets shift our x vector since our tank is at x=90 and not x=0

for i=1:200   %this loop plots our projectile over time. It moves along the parabola so we can see the profectile fly. Note you could just plot the parabola directly but this is mor fun!
    figure(1)
plot(xmove(i),y(i),'.','color',[0 0 0]);  %plots the projectile as a dot in each step
end

