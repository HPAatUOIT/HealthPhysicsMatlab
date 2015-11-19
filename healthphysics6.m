% Survival fraction and relative biological effectiveness of high LET radiation
clf

D=linspace(0,14,10000); %% we will give doses from 0 to 14 Gy

% ln(SF) = -(aD + bD^2)  (the survival fraction of cells for dose D is quadratic)

% SF = exp(-aD + bD^2)  where a describes single track damage of the
% specific radiation and b describes double track action of the radiation

% radiation 1 will be our low LET reference radiation (250 kVp x-rays) 
%--------------------------------------------------------------------
a1=0.064; %% survival per Gy. Very little single track action for x-rays (# tracks porpotional to dose)
b1=0.0165; %% survival per Gy^2 (# double tracks porpotional to dose^2)

SFxray=exp(-(a1*D+b1*D.^2));  %survival curve for reference radiation

semilogy(D,SFxray) %plot it with log scale for SF lin scale for Dose
xlabel('Dose (Gy)')
ylabel('Survival Fraction')
hold on
%--------------------------------------------------------------------


% radiation 2 will be high LET test radiation (6.3 MeV Heliumed-3 heavy charged particles: 91 KeV/um) 
%--------------------------------------------------------------------
a2=0.551; %% survival per Gy. MUCH MORE single track action for high LET (# tracks porpotional to dose)
b2=0.0165; %% survival per Gy^2 (# double tracks porpotional to dose^2)

SF6MeVHe3=exp(-(a2*D+b2*D.^2));  %survival curve for reference radiation

semilogy(D,SF6MeVHe3,'color',[1 0 0]) %plot it with log scale for SF lin scale for Dose
%--------------------------------------------------------------------

% radiation 3 will be higher LET test radiation (4.3 MeV Heliumed-3 heavy charged particles: 170 KeV/um) 
%--------------------------------------------------------------------
a3=0.710; %% survival per Gy. EVEN MORE single track action for higher LET (# tracks porpotional to dose)
b3=0.0165; %% survival per Gy^2 (# double tracks porpotional to dose^2)

SF4MeVHe3=exp(-(a3*D+b3*D.^2));  %survival curve for reference radiation

semilogy(D,SF4MeVHe3,'color',[0 1 0]) %plot it with log scale for SF lin scale for Dose

legend('250 kVp x-rays', '6.3 MeV He-3', '4.3 MeV He-3')

%--------------------------------------------------------------------
%--------------------------------------------------------------------
%--------------------------------------------------------------------


% searchxray=(SFxray-0.05).^2;  %% square of difference from 5% survival. Minimize this to find value
% thedoseindex=find(searchxray==min(searchxray)); %%find the min of difference squared. this is the index of our value
% 
% refDose=D(thedoseindex); %%the dose at the index we found is the dose required to kill 95% of cells with the xrays
% 
% plot(refDose,0.05,'*','color',[0 0 0])
% 
% %--------------------------------------------------------------------
% 
% search6MeV=(SF6MeVHe3-0.05).^2;  %% square of difference from 5% survival. Minimize this to find value
% thedoseindex2=find(search6MeV==min(search6MeV)); %%find the min of difference squared. this is the index of our value
% 
% testDose1=D(thedoseindex2); %%the dose at the index we found is the dose required to kill 95% of cells with the 6.3 MeV He3
% 
% plot(testDose1,0.05,'*','color',[0 0 0])
% 
% %--------------------------------------------------------------------
% 
% search4MeV=(SF4MeVHe3-0.05).^2;  %% square of difference from 5% survival. Minimize this to find value
% thedoseindex3=find(search4MeV==min(search4MeV)); %%find the min of difference squared. this is the index of our value
% 
% testDose2=D(thedoseindex3); %%the dose at the index we found is the dose required to kill 95% of cells with the 6.3 MeV He3
% 
% plot(testDose2,0.05,'*','color',[0 0 0])
% 
% RBE1=refDose/testDose1
% 
% RBE2=refDose/testDose2



