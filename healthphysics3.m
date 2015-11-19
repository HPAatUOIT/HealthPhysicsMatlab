clf

iterations=10000;  %how many points to use. More points means more accuracy
count=0; %count up how many points are in our circle

for z=1:iterations  %we use this loop to plot random points in a square from -1 to 1 in the x,y axis
x=2*rand-1;   %random x point
y=2*rand-1;   %random y point

if x^2+y^2<1   %Now we draw a circle in our square so it has a diameter of 2 (equal to square width)if our random point hits in the circle then count it
    plot(x,y,'*','color','r')  %plot red point in circle
    count=count+1; %count up how many in circle hits we get
else 
    plot(x,y,'*')  %plot blue points if we hit outside circle (and don't count it)
end
hold on 
end
axis([-2 2 -2 2])

% the circle has an area of pi*r^2 or pi in our case (r=1). The square has an
% area of 2*2 = 4 SO the ratio of random points in the circle is pi/4  

piguess=4*count/iterations;  %our in circle hit ratio is pi/4 so multiply our hits by 4 to get our estimate of pi

disp('pi is approximately')
piguess
