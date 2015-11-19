clf
[a b c]=sphere; %makes a sphere
axis equal
hold on
a=10*a;
b=10*b;
c=10*c;

surface(a,b,c,'FaceColor',[0.9 0.9 0.9],'Edgecolor',[0.9 0.9 0.9],'FaceAlpha',0.5)

for j=1:20    %number of particles to plot
    
    position=[0 0 0];         %starting particle position
    colour=[rand rand rand];  %colorize each particle
    
    for i=1:500     %number of points to track in each particle path
        x=position(1);
        y=position(2);
        z=position(3);
        if norm(position)>10     %if particle is in the world
            plot3(x,y,z,'*')     %if it has left the world end track with point *
        break
        end
                
       distance=abs(randn);      %distance traveled straight without colliding in this step

        theta=360*rand;   %azimuthal angle after collision
        phi=180*rand;     %altitude angle after collision

        trajectory=[distance*cosd(theta)*sind(phi) distance*sind(theta)*sind(phi) distance*cosd(phi)];  %travel vector in this step


        plot3([x,x+trajectory(1)],[y,y+trajectory(2)],[z,z+trajectory(3)],'color',colour);   %plot the particle trajectory in this step
        hold on
        position=position+trajectory;  %update the particles position from this step
        
        

    end
end
