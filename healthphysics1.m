% Created for Health Physics Association at UOIT MATLAB workshop by Alex Miller 
% Feb 2014
clf %clears the figures
position=[500 500]; %true position of the CN tower

angle1=45; %% at origin
angle2=49; %% 50 m down the street
angle3=51; %% 100 m down street

m1=tand(angle1); %slopes of the linear equations
m2=tand(angle2);
m3=tand(angle3);

b1=0-m1*0; % y-intercepts of the linear equations
b2=0-m2*50;
b3=0-m3*100;

A=[1 -m1;1 -m2];  %invertible martix for equations 1 and 2
b=[b1;b2]; % y-intercept vector for equations 1 and 2

C=[1 -m1;1 -m2;1 -m3]; % non-invertable over constrained matrix for all three equations
d=[b1;b2;b3]; % y-intercept vector for all three equations

posguess=inv(A)*b %this is the position we guess only from the first two measurements using invertible matrix.

pos=C\d %this is the position we guess with the sum of least squares from over constrained system

x=[0:1000]; %xvectors for our plot

line1=m1*x+b1; %yvectors for our three linear equations
line2=m2*x+b2;
line3=m3*x+b3;

plot(x,line1) %plot line 1
axis([0 1000 0 1000]) %make axis look nice
hold on %hold on for more plots
plot(x,line2,'color',[0 1 0]) %plot line 2 with different colour
plot(x,line3,'color',[0 0 0]) %plot line 3 different colour

plot(pos(1,1),pos(2,1),'*','color','r')  %plot our overconstrained best guess point
plot(posguess(1,1),posguess(2,1),'*','color',[1 0 1]) %plot our first guess with only 2 equations (invertable matrix)

plot(500,500,'O','color',[0 0 0]) %plot the true CN tower position as an O 






