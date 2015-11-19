function[]= boronneutronscatter(flux,iterations,rez,slabthickness)
global transmitted escape backscatter radiativecapture alpha 
transmitted=0;
escape=0;
backscatter=0;
radiativecapture=0;
alpha=0;
% plots neutron scattering path. 
%flux is total number of incident neutrons in 1 cm^2
%iterations is the maximum iterations that can be spent tracking 1 individual particle
%rez sets the resolution size of the iteratons (maximum distance between iteration calculation points in mm)   
%slabthickness is the dimentions of the slab sample in mm (cube)
shg
clf reset
rng('shuffle')
set(gcf,'color','white','name','neutron scattering')
A=10; %boron nucleus
neutronenergy=[0.00001 0.000010625 0.00001125 0.000011875 0.0000125 0.00001375 0.000015 0.00001625 0.0000175 0.00001875 0.00002 0.000021875 0.00002375 0.000025625 0.0000275 0.000029375 0.00003125 0.000033125 0.000035 0.00003875 0.0000425 0.00004625 0.00005 0.000053125 0.00005625 0.000059375 0.0000625 0.00006875 0.000075 0.00008125 0.0000875 0.00009375 0.0001 0.00010625 0.0001125 0.00011875 0.000125 0.0001375 0.00015 0.0001625 0.000175 0.0001875 0.0002 0.00021875 0.0002375 0.00025625 0.000275 0.00029375 0.0003125 0.00033125 0.00035 0.0003875 0.000425 0.0004625 0.0005 0.00053125 0.0005625 0.00059375 0.000625 0.0006875 0.00075 0.0008125 0.000875 0.0009375 0.001 0.001062 0.001125 0.001188 0.00125 0.001375 0.0015 0.001625 0.00175 0.001875 0.002 0.002188 0.002375 0.002562 0.00275 0.002938 0.003125 0.003312 0.0035 0.003875 0.00425 0.004625 0.005 0.005312 0.005625 0.005938 0.00625 0.006875 0.0075 0.008125 0.00875 0.009375 0.01 0.010625 0.01125 0.011875 0.0125 0.01375 0.015 0.01625 0.0175 0.01875 0.02 0.021325 0.02265 0.023975 0.0253 0.026844 0.028388 0.029931 0.031475 0.034562 0.03765 0.040738 0.043825 0.046912 0.05 0.053125 0.05625 0.059375 0.0625 0.06875 0.075 0.08125 0.0875 0.09375 0.1 0.10625 0.1125 0.11875 0.125 0.1375 0.15 0.1625 0.175 0.1875 0.2 0.21875 0.2375 0.25625 0.275 0.29375 0.3125 0.33125 0.35 0.3875 0.425 0.5 0.625 0.75 0.875 1 1.25 1.5 1.75 2 2.375 2.75 3.125 3.5 4.25 5 5.55 6.1 6.65 7.2 8.3 9.4 10 11.25 12.5 15 17.5 20 23.75 27.5 31.25 35 42.5 50 62.5 75 87.5 100 125 150 175 200 225 250 275 300 325 350 400 450 500 550 600 650 750 850 950 1000 1125 1250 1500 1750 2000 2250 2500 2750 3000 3250 3500 4000 4500 5000 5500 6000 6500 7500 8500 9500 10000 11250 12500 15000 17500 20000 22000 24000 27000 30000 37500 45000 50000 51000 55000 60000 65000 75000 85000 95000 100000 110000 120000 135000 150000 170000 180000 190000 200000 200019.6 200039.1 200078.2 200156.3 200312.5 200625 201250 202500 205000 210000 220000 230000 235000 240000 245000 250000 260000 270000 280000 300000 320000 340000 360000 380000 400000 420000 440000 460000 480000 500000 505000] ;
scattercross=[41.10681 39.88271 38.76219 37.73142 36.77903 35.07314 33.58544 32.2731 31.1042 30.0544 29.10478 27.83628 26.72141 25.7315 24.84485 24.04471 23.31789 22.65385 22.04406 20.96046 20.02411 19.20448 18.47924 17.93474 17.43648 16.97827 16.55506 15.79735 15.13698 14.55483 14.03664 13.57156 13.15112 12.76867 12.41882 12.09723 11.80032 11.26906 10.80642 10.3989 10.03645 9.711402 9.417792 9.02629 8.682939 8.378727 8.106835 7.861992 7.640057 7.437723 7.252314 6.923872 6.641256 6.394908 6.177839 6.015488 5.867434 5.731752 5.606858 5.384385 5.191804 5.023173 4.874071 4.741132 4.621746 4.51385 4.415793 4.326234 4.244073 4.098435 3.973184 3.864205 3.768446 3.683587 3.607831 3.508253 3.422392 3.347569 3.28177 3.223447 3.171391 3.124645 3.082435 3.009228 2.947945 2.895911 2.851195 2.818481 2.789213 2.762881 2.739068 2.697695 2.662997 2.633494 2.60811 2.586045 2.566692 2.549582 2.53435 2.520702 2.508406 2.487138 2.469389 2.454355 2.441458 2.430274 2.420484 2.411358 2.4033 2.396134 2.38972 2.383049 2.377108 2.371783 2.366985 2.358684 2.351756 2.345887 2.340851 2.336483 2.332657 2.329239 2.326202 2.323485 2.32104 2.316817 2.313298 2.310319 2.307764 2.30555 2.303612 2.301901 2.300379 2.299017 2.297791 2.295671 2.293903 2.292405 2.291119 2.290003 2.289025 2.287766 2.286702 2.285792 2.285003 2.284313 2.283704 2.283161 2.282675 2.281839 2.281145 2.280052 2.278777 2.277889 2.277222 2.276713 2.276057 2.275611 2.275275 2.275009 2.274691 2.274435 2.27422 2.274031 2.273706 2.273426 2.273237 2.273059 2.272889 2.272725 2.272409 2.272123 2.272055 2.271952 2.271855 2.271674 2.271504 2.271341 2.271105 2.270875 2.270649 2.270425 2.269985 2.269547 2.268825 2.268105 2.267389 2.266674 2.265245 2.26383 2.263166 2.262514 2.261863 2.261214 2.26071 2.260209 2.259709 2.25921 2.258407 2.257608 2.256956 2.256306 2.255755 2.255206 2.254305 2.253504 2.250393 2.118407 2.149304 2.182904 2.249804 2.249652 2.249201 2.248751 2.248304 2.248376 2.248451 2.248526 2.248603 2.249351 2.250102 2.251201 2.252302 2.25375 2.255201 2.258501 2.262101 2.266002 2.268291 2.274018 2.279745 2.291202 2.3042 2.317202 2.3283 2.339401 2.35675 2.374102 2.41985 2.465591 2.48885 2.493526 2.528284 2.5599 2.5915 2.6547 2.717299 2.779199 2.809699 2.8694 2.929097 3.01435 3.099597 3.207898 3.260398 3.311298 3.360297 3.36039 3.360481 3.360663 3.361025 3.36175 3.3632 3.3661 3.3719 3.3835 3.406696 3.449895 3.489296 3.507497 3.524597 3.540597 3.555395 3.581493 3.603093 3.620091 3.641789 3.648886 3.638997 3.625095 3.605798 3.584701 3.564702 3.546699 3.527694 3.50209 3.466291 3.455025] ;
nalphacross=[194116.9 188321 183015.1 178133.8 173623.3 165543.2 158495.4 152277.4 146738.1 141762.4 137260.7 131246.2 125958.8 121263 117055.9 113258.4 109808 106654.8 103758.6 98610.1 94159.04 90260.93 86810.02 84217.96 81845.04 79661.99 77644.79 74031.18 70879.24 68098.37 65621.03 63395.74 61382.48 59549.57 57871.61 56327.92 54901.49 52346.21 50117.38 48150.93 46399.12 44825.54 43401.88 41499.77 39827.59 38342.47 37011.94 35810.92 34719.67 33722.43 32806.43 31178.09 29770.31 28537.41 27445.93 26626.09 25875.54 25185.05 24547.01 23404 22407.01 21527.37 20743.74 20039.82 19402.96 18823.14 18292.33 17803.98 17352.73 16544.35 15839.22 15217.09 14662.85 14164.99 13714.56 13112.74 12583.65 12113.75 11692.75 11312.73 10967.44 10651.89 10362.05 9846.815 9401.37 9011.263 8665.912 8406.515 8169.048 7950.588 7748.729 7387.131 7071.748 6793.51 6545.659 6323.041 6121.649 5938.313 5770.49 5616.109 5473.469 5217.98 4995.175 4798.639 4623.592 4466.389 4324.193 4187.363 4062.749 3948.639 3843.636 3731.266 3628.213 3533.258 3445.392 3287.702 3149.866 3028.038 2919.34 2821.572 2733.015 2651.37 2576.633 2507.878 2444.346 2330.532 2231.25 2143.648 2065.607 1995.512 1932.106 1874.392 1821.567 1772.977 1728.082 1647.649 1577.475 1515.549 1460.382 1410.835 1366.012 1306.121 1253.453 1206.664 1164.748 1126.931 1092.6 1061.254 1032.475 981.2908 936.9858 863.9246 772.6654 705.1834 653.0307 610.963 546.2449 498.5282 461.6581 431.8492 396.2903 368.3562 345.4572 326.3624 296.089 272.9722 259.1028 247.1173 236.6552 227.4788 211.8925 199.0372 192.9461 181.8936 172.5091 157.404 145.6963 136.2551 124.991 116.133 108.9056 102.8767 93.3157 86.00661 76.89247 70.16394 64.94183 60.73425 54.29494 49.54444 45.8437 42.86242 40.39187 38.30292 36.50422 34.93603 33.55305 32.3226 30.21497 28.46912 26.99207 25.72207 24.61433 23.63812 21.98631 20.63675 19.5041 19.00321 17.9015 16.96981 15.4707 14.30547 13.36734 12.59082 11.93451 11.37006 10.87812 10.44439 10.05837 9.398416 8.852221 8.391051 7.994614 7.649527 7.345316 6.831932 6.41308 6.063215 5.909332 5.570639 5.28411 4.822677 4.4686 4.183001 4.00455 3.826306 3.6309 3.435725 3.13775 2.839991 2.71635 2.69164 2.592842 2.5006 2.408429 2.264622 2.149017 2.053811 2.012213 1.9436 1.875018 1.79985 1.724709 1.641101 1.600199 1.558498 1.515598 1.515512 1.515426 1.515253 1.514906 1.514212 1.512825 1.51005 1.5045 1.4934 1.471198 1.425399 1.3787 1.3552 1.3317 1.308301 1.285201 1.239603 1.195903 1.154306 1.07951 1.017612 0.970734 0.940866 0.929997 0.938583 0.962081 0.986892 0.992117 0.962989 0.902804 0.883898];
radcapturecross=[25.15856 24.40739 23.71972 23.08708 22.5025 21.45529 20.54188 19.73599 19.01808 18.37321 17.78978 17.01029 16.32503 15.71642 15.17118 14.67901 14.23183 13.82317 13.44781 12.78056 12.20369 11.69849 11.25125 10.91531 10.60778 10.32485 10.06342 9.595097 9.186606 8.826205 8.505144 8.21675 7.955834 7.718292 7.500832 7.300773 7.115913 6.784757 6.49591 6.241069 6.014044 5.810118 5.625623 5.379124 5.162426 4.969969 4.797547 4.641909 4.500498 4.37127 4.252571 4.041566 3.859144 3.699386 3.557955 3.451723 3.354472 3.265003 3.182331 3.034233 2.905057 2.791088 2.68956 2.598361 2.515852 2.440735 2.371968 2.308704 2.250246 2.145524 2.054183 1.973594 1.901803 1.837315 1.778973 1.701022 1.632496 1.571635 1.51711 1.467893 1.423174 1.382308 1.344772 1.278045 1.220358 1.169837 1.125112 1.091517 1.060763 1.03247 1.006326 0.959492 0.918642 0.882601 0.850494 0.821653 0.79556 0.771805 0.750058 0.730052 0.711565 0.678448 0.649563 0.624078 0.601375 0.580983 0.562534 0.544777 0.528603 0.513788 0.500154 0.48556 0.472174 0.459836 0.448418 0.427922 0.410002 0.39416 0.380022 0.367305 0.355785 0.345164 0.33544 0.326495 0.318229 0.30342 0.290501 0.279102 0.268947 0.259826 0.251575 0.244064 0.23719 0.230867 0.225024 0.214556 0.205424 0.197364 0.190184 0.183735 0.177901 0.170106 0.163251 0.15716 0.151704 0.146782 0.142312 0.138232 0.134486 0.127822 0.122055 0.112543 0.100661 0.091875 0.085084 0.079606 0.071178 0.064964 0.060162 0.05628 0.051648 0.04801 0.045027 0.042539 0.038596 0.035584 0.033777 0.032216 0.030853 0.029657 0.027626 0.025951 0.02516 0.023724 0.022504 0.020541 0.019019 0.017791 0.016326 0.015173 0.014232 0.013447 0.012202 0.01125 0.010062 0.009185 0.008504 0.007955 0.007115 0.006494 0.006013 0.005625 0.005303 0.005031 0.004796 0.004592 0.004412 0.004251 0.003977 0.003749 0.003557 0.003391 0.003247 0.00312 0.002904 0.002728 0.00258 0.002515 0.002371 0.00225 0.002054 0.001901 0.001778 0.001677 0.001591 0.001517 0.001452 0.001395 0.001344 0.001258 0.001186 0.001125 0.001072 0.001027 0.0009864608 0.0009183489 0.0008626335 0.0008159619 0.0007953008 0.0007498204 0.0007113396 0.0006493581 0.0006011898 0.0005623621 0.0005361888 0.0005133621 0.0004840026 0.0004591648 0.0004106883 0.0003749048 0.0003556647 0.0003521598 0.0003391133 0.0003246762 0.0003119393 0.0002904001 0.0002727829 0.000258026 0.0002514923 0.0002397888 0.0002295803 0.0002164504 0.0002053429 0.0001928857 0.0001874508 0.0001824512 0.0001778313 0.0001778227 0.0001778142 0.0001777974 0.0001777639 0.000177697 0.000177563 0.0001772952 0.0001767595 0.000175688 0.0001735456 0.0001695555 0.0001658284 0.0001640548 0.0001623368 0.0001606717 0.000159057 0.0001559683 0.0001530527 0.0001502948 0.0001451987 0.0001405879 0.0001363903 0.0001325476 0.0001290122 0.0001257456 0.0001227151 0.0001198937 0.0001172583 0.0001147894 0.0001124701 0.0001119119] ;
% Boron-10 cross sections given in barns at energy group a given by index a from 1 to 288 of neutronenergy group vector

axis equal
figure(1)
%%axis([-50 slabthickness+10 -101 101 -101 101])
[y,z]=meshgrid(-100:10:100);
x=ones(21,21);
mesh(x,y,z,'facecolor',[0.2 0.2 0.2],'facealpha',0.6,'edgecolor',[0.2 0.2 0.2],'edgealpha',0) % plots a surface at the incident yz boron boundry.
hold on
x=slabthickness*ones(21,21);
mesh(x,y,z,'facecolor',[0.2 0.2 0.2],'facealpha',0.6,'edgecolor',[0.2 0.2 0.2],'edgealpha',0) % plots a surface at the end of the sample yz boron boundry.
[x,y]=meshgrid(linspace(0,slabthickness,21),linspace(-100,100,21));
z=-100*ones(21,21);
mesh(x,y,z,'facecolor',[0.2 0.2 0.2],'facealpha',0.6,'edgecolor',[0.2 0.2 0.2],'edgealpha',0) % plots a surface at the bottom of the sample xy boron boundry.
z=-z;
mesh(x,y,z,'facecolor',[0.2 0.2 0.2],'facealpha',0.6,'edgecolor',[0.2 0.2 0.2],'edgealpha',0) % plots a surface at the top of the sample xy boron boundry.

[x,z]=meshgrid(linspace(0,slabthickness,21),linspace(-100,100,21));
y=100*ones(21,21);
mesh(x,y,z,'facecolor',[0.2 0.2 0.2],'facealpha',0.6,'edgecolor',[0.2 0.2 0.2],'edgealpha',0)  %%plots the back at the xz surface

	for k=1:flux
		neutronfn([-40 (10/rez)*rand (10/rez)*rand],iterations,neutronenergy,scattercross,nalphacross,radcapturecross,rez,slabthickness) 
		% scattering and absorption function for incident neutron flux
		hold on 
	end


%transmitted=flux-escape-backscatter-radiativecapture-absorption;
transmitted
escape
backscatter
radiativecapture
alpha
end

function[]=neutronfn(pos,iterations,neutronenergy,scattercross,nalphacross,radcapturecross,rez,slabthickness)
            global transmitted escape backscatter radiativecapture alpha     
     figure(1)
        for i=1:iterations 
        if i==1 %the first iteration is for neutrons outside the scattering sample 
			a=288; % the incident neutron energy index
			
            if a>288||a==0
                a=288;
            end
            E=[neutronenergy(a)/505000 0 1-neutronenergy(a)/505000]; %energy color vector for plotted neutron path
			next=pos+[40 0 0];
			plot3([pos(1) next(1)],[pos(2) next(2)],[pos(3) next(3)],'color',E);
            pos =[pos(1)+40 pos(2) pos(3)] ; %changes start position for next iteration
			r=[40 0 0];
            r=r/norm(r); % r is the direction vector the incident neutrons  
            X=rand;
		elseif pos(1)<0
				% neutrons behind x=0 are outside the sample and have been backscattered
				next=pos+r*55*rez;
                plot3([pos(1) next(1)],[pos(2) next(2)],[pos(3) next(3)],'color',E);
                backscatter=backscatter+1;
                break;
		elseif abs(pos(2))>100*slabthickness || abs(pos(3))>100*slabthickness ||pos(1)>slabthickness 
				%outside |y|=300 |z|=300 or the theckniss X=0 to X=slabthickness, the neutrons have escaped the sample
				next = pos + 100*r; % determines the next vector to plot
                plot3([pos(1) next(1)],[pos(2) next(2)],[pos(3) next(3)],'color',E);
                pos = next; %changes start position for next iteration
                if a==288
                    transmitted=transmitted+1;
                else
                    escape=escape+1;
                end
                    break;
		elseif  pos(1)>=0				
			scatter=scattercross(a); %the scattering cross section at index a from neutronenegy
			nalpha=nalphacross(a);
			radcapture=radcapturecross(a);
			X=rez*rand;
            if rand<=(1-exp(-X*0.014134*rez*radcapture))  %radiative capture plots o at point and ends function
				plot3([pos(1)],[pos(2)],[pos(3)],'o','color',[0 0.5 0]);
				radiativecapture=radiativecapture+1;
                break;
			elseif rand<=(1-exp(-X*0.014134*rez*nalpha)) %absorption plots o at neutron absorption point and ends function
				   plot3([pos(1)],[pos(2)],[pos(3)],'o','color',[0 0 0]);
				   alpha=alpha+1;
                   break;
            elseif rand<=(1-exp(-X*0.014134*rez*scatter))  %if not captured or absorbed then scattered at angle theta,phi 
					theta=2*pi*rand;
					phi=pi*rand;
					rn = [cos(theta) sin(theta) cos(phi)]; % r is the new direction vector after scatter for the iteration       
					rn=rn/norm(rn);
					angle=acos(rn*r');
					decrement=round(10*angle/pi);
					 if decrement>=a
                            a=1;
                        else    
                        a=(abs(a-decrement));
                        end
                    r=rn;
			
			end
		end	
	E=[neutronenergy(a)/505000 0 1-neutronenergy(a)/505000]; %energy color vector for plotted neutron path
	next = pos + X*r; % determines the next vector to plot
    plot3([pos(1) next(1)],[pos(2) next(2)],[pos(3) next(3)],'color',E);
    pos = next; %changes start position for next iteration
	end
end				


  