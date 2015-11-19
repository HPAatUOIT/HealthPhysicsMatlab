dcf=xlsread('icrp74iso.xlsx'); %neutron dose conversion pSv cm^2 from icrp74
AmBespectra=xlsread('AmBespectra.xlsx'); %AmBe p(E) spectra

intensity=2.7*10^6*40*10^-3; %AmBe intensity n/sec

time=118.6; % sec (118.6 sec = 1 mrem at 5cm distance)

Io=intensity*time; % neutrons

pointflux=Io/(4*pi*5^2); %flux at 5cm away from source neutrons/cm^2

dcfenergy=dcf(:,1);   %x-axis is energy
dcfenergy=dcfenergy';
dcfy=dcf(:,2);        %y-axis is dose converstion pSv cm^2  
dcfy=dcfy';

energy=AmBespectra(:,1);
energy=energy'; %energies used for calculation
flux=AmBespectra(:,2); % freq spectra n/cm^2
flux=pointflux*flux';


doseconversion=interp1(dcfenergy,dcfy,energy,'cubic');  %%interpolate the dcf at the energy from spectrum bins

figure(1)
plot(dcfenergy,dcfy,'*');
hold on
plot(energy,doseconversion,'color','r');

figure(2)
plot(energy,flux,'*');
hold on
plot(energy,flux,'color','r');

Dosespectrum=flux.*doseconversion;   %% Dose = dcf * flux

dose=sum(Dosespectrum)*10^-6*0.1 % Dose in mRem
