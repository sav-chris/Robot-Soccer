%Membership function constants

function PlotMembershipFunctions

%Distance membership function constants
Dis_Zmin=0;
Dis_Z1=0;
Dis_Z2=0;
Dis_Zmax=0.2;

Dis_Pmin=0;
Dis_P1=0.2;
Dis_P2=0.4;
Dis_Pmax=0.7;

Dis_LPmin=0.2;
Dis_LP1=0.7;

%Angle membership function constants
Angle_LNmin=-60;
Angle_LNmax=-30;

Angle_Nmin=-60;
Angle_Ntop=-30;
Angle_Nmax=0;

Angle_Zmin=-30;
Angle_Ztop=0;
Angle_Zmax=30;

Angle_Pmin=0;
Angle_Ptop=30;
Angle_Pmax=60;

Angle_LPmin=30;
Angle_LPmax=60;

%Speed membership function constants

Speed_LNmin=-30;
Speed_LNtop=-20;
Speed_LNmax=-10;

Speed_Nmin=-20;
Speed_Ntop=-10;
Speed_Nmax=0;

Speed_Zmin=-10;
Speed_Ztop=0;
Speed_Zmax=10;

Speed_Pmin=0;
Speed_Ptop=10;
Speed_Pmax=20;

Speed_LPmin=10;
Speed_LPtop=20;
Speed_LPmax=30;

%PLOTS

precision=10000;

%Plot distance membership functions

x=linspace(-.2,1.2,precision);

for i=1:precision
    
    %determining Z membership function
    
    if x(i)<Dis_Zmin
        z(i)=0;
    elseif x(i)>Dis_Zmin && x(i)<Dis_Z1
        z(i)=(x(i)-Dis_Zmin)*(1/(Dis_Z1-Dis_Zmin));
    elseif x(i)>=Dis_Z1 && x(i)<=Dis_Z2
        z(i)=1;
    elseif x(i)>Dis_Z2 && x(i)<Dis_Zmax
        z(i)=1-((x(i)-Dis_Z2)*(1/(Dis_Zmax-Dis_Z2)));
    elseif x(i)>=Dis_Zmax
        z(i)=0;
    end
    
    %determining P membership function
    
    if x(i)<Dis_Pmin
        p(i)=0;
    elseif x(i)>Dis_Pmin && x(i)<Dis_P1
        p(i)=(x(i)-Dis_Pmin)*(1/(Dis_P1-Dis_Pmin));
    elseif x(i)>=Dis_P1 && x(i)<=Dis_P2
        p(i)=1;
    elseif x(i)>Dis_P2 && x(i)<Dis_Pmax
        p(i)=1-((x(i)-Dis_P2)*(1/(Dis_Pmax-Dis_P2)));
    elseif x(i)>=Dis_Pmax
        p(i)=0;
    end
    
    %determining LP membership function
    
    if x(i)<Dis_LPmin
        lp(i)=0;
    elseif x(i)>Dis_LPmin && x(i)<Dis_LP1
        lp(i)=(x(i)-Dis_LPmin)*(1/(Dis_LP1-Dis_LPmin));
    elseif x(i)>=Dis_LP1 
        lp(i)=1;
    end
end
    

figure(1);
plot(x,z);
hold on;
plot(x,p,'r');
plot(x,lp,'g');
hold off;

%Plot angle membership function

w=linspace(-90,90,precision);

for i=1:precision
    
    %determine LN membership angle function
    
    if w(i)<= Angle_LNmin
        Angle_LN(i)=1;
    elseif w(i)>= Angle_LNmax
        Angle_LN(i)=0;
    elseif w(i)>Angle_LNmin && w(i)<Angle_LNmax
        Angle_LN(i)=1-((w(i)-Angle_LNmin)*(1/(Angle_LNmax-Angle_LNmin)));
    end
    
    %determining N membership angle function
    
    if w(i)<=Angle_Nmin
        Angle_N(i)=0;
    elseif w(i)>Angle_Nmin && w(i)<=Angle_Ntop
        Angle_N(i)=((w(i)-Angle_Nmin)*(1/(Angle_Ntop-Angle_Nmin)));
    elseif w(i)>Angle_Ntop && w(i)<Angle_Nmax
        Angle_N(i)=1-((w(i)-Angle_Ntop)*(1/(Angle_Nmax-Angle_Ntop)));
    elseif w(i)>=Angle_Nmax
        Angle_N(i)=0;
    end
    
    %determining Z membership angle function
    
    if w(i)<=Angle_Zmin
        Angle_Z(i)=0;
    elseif w(i)>Angle_Zmin && w(i)<=Angle_Ztop
        Angle_Z(i)=((w(i)-Angle_Zmin)*(1/(Angle_Ztop-Angle_Zmin)));
    elseif w(i)>Angle_Ztop && w(i)<Angle_Zmax
        Angle_Z(i)=1-((w(i)-Angle_Ztop)*(1/(Angle_Zmax-Angle_Ztop)));
    elseif w(i)>=Angle_Zmax
        Angle_Z(i)=0;
    end
    
    %determining the positive angle mebership function
    
    if w(i)<=Angle_Pmin
        Angle_P(i)=0;
    elseif w(i)>Angle_Pmin && w(i)<=Angle_Ptop
        Angle_P(i)=((w(i)-Angle_Pmin)*(1/(Angle_Ptop-Angle_Pmin)));
    elseif w(i)>Angle_Ptop && w(i)<Angle_Pmax
        Angle_P(i)=1-((w(i)-Angle_Ptop)*(1/(Angle_Pmax-Angle_Ptop)));
    elseif w(i)>=Angle_Pmax
        Angle_P(i)=0;
    end
    
    %determining the large positive angle membership function
    
     if w(i)<= Angle_LPmin
        Angle_LP(i)=0;
    elseif w(i)>= Angle_LPmax
        Angle_LP(i)=1;
    elseif w(i)>Angle_LPmin && w(i)<Angle_LPmax
        Angle_LP(i)=((w(i)-Angle_LPmin)*(1/(Angle_LPmax-Angle_LPmin)));
    end
    
    
    
end

figure(2);
plot(w,Angle_LN,'c');
hold on;
plot(w,Angle_N,'m');
plot(w,Angle_Z,'b');
plot(w,Angle_P,'r');
plot(w,Angle_LP,'g');
hold off;
