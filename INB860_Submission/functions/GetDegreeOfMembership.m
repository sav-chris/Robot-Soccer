%Membership function constants

function [Mu_Distance, Mu_Angle]=GetDegreeOfMembership(Distance, Angle)

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


%Get degree of membership
%------------------------


    
    %determining Z membership level
    
    if Distance<Dis_Zmin
        mu_z=0;
    elseif Distance>Dis_Zmin && Distance<Dis_Z1
        mu_z=(Distance-Dis_Zmin)*(1/(Dis_Z1-Dis_Zmin));
    elseif Distance>=Dis_Z1 && Distance<=Dis_Z2
        mu_z=1;
    elseif Distance>Dis_Z2 && Distance<Dis_Zmax
        mu_z=1-((Distance-Dis_Z2)*(1/(Dis_Zmax-Dis_Z2)));
    elseif Distance>=Dis_Zmax
        mu_z=0;
    end
    
    %determining P membership level
    
    if Distance<Dis_Pmin
        mu_p=0;
    elseif Distance>Dis_Pmin && Distance<Dis_P1
        mu_p=(Distance-Dis_Pmin)*(1/(Dis_P1-Dis_Pmin));
    elseif Distance>=Dis_P1 && Distance<=Dis_P2
        mu_p=1;
    elseif Distance>Dis_P2 && Distance<Dis_Pmax
        mu_p=1-((Distance-Dis_P2)*(1/(Dis_Pmax-Dis_P2)));
    elseif Distance>=Dis_Pmax
        mu_p=0;
    end
    
    %determining LP membership level
    
    if Distance<Dis_LPmin
        mu_lp=0;
    elseif Distance>Dis_LPmin && Distance<Dis_LP1
        mu_lp=(Distance-Dis_LPmin)*(1/(Dis_LP1-Dis_LPmin));
    elseif Distance>=Dis_LP1 
        mu_lp=1;
    end

    


%Get angle membership level




    
    %determine LN membership level
    
    if Angle<= Angle_LNmin
        Mu_AngleLN=1;
    elseif Angle>= Angle_LNmax
        Mu_AngleLN=0;
    elseif Angle>Angle_LNmin && Angle<Angle_LNmax
        Mu_AngleLN=1-((Angle-Angle_LNmin)*(1/(Angle_LNmax-Angle_LNmin)));
    end
    
    %determining N membership level
    
    if Angle<=Angle_Nmin
        Mu_AngleN=0;
    elseif Angle>Angle_Nmin && Angle<=Angle_Ntop
        Mu_AngleN=((Angle-Angle_Nmin)*(1/(Angle_Ntop-Angle_Nmin)));
    elseif Angle>Angle_Ntop && Angle<Angle_Nmax
        Mu_AngleN=1-((Angle-Angle_Ntop)*(1/(Angle_Nmax-Angle_Ntop)));
    elseif Angle>=Angle_Nmax
        Mu_AngleN=0;
    end
    
    %determining Z membership level
    
    if Angle<=Angle_Zmin
        Mu_AngleZ=0;
    elseif Angle>Angle_Zmin && Angle<=Angle_Ztop
        Mu_AngleZ=((Angle-Angle_Zmin)*(1/(Angle_Ztop-Angle_Zmin)));
    elseif Angle>Angle_Ztop && Angle<Angle_Zmax
        Mu_AngleZ=1-((Angle-Angle_Ztop)*(1/(Angle_Zmax-Angle_Ztop)));
    elseif Angle>=Angle_Zmax
        Mu_AngleZ=0;
    end
    
    %determining the positive angle membership level
    
    if Angle<=Angle_Pmin
        Mu_AngleP=0;
    elseif Angle>Angle_Pmin && Angle<=Angle_Ptop
        Mu_AngleP=((Angle-Angle_Pmin)*(1/(Angle_Ptop-Angle_Pmin)));
    elseif Angle>Angle_Ptop && Angle<Angle_Pmax
        Mu_AngleP=1-((Angle-Angle_Ptop)*(1/(Angle_Pmax-Angle_Ptop)));
    elseif Angle>=Angle_Pmax
        Mu_AngleP=0;
    end
    
    %determining the large positive angle membership level
    
     if Angle<= Angle_LPmin
        Mu_AngleLP=0;
    elseif Angle>= Angle_LPmax
        Mu_AngleLP=1;
    elseif Angle>Angle_LPmin && Angle<Angle_LPmax
        Mu_AngleLP=((Angle-Angle_LPmin)*(1/(Angle_LPmax-Angle_LPmin)));
    end
    
 Mu_Distance=[mu_z mu_p mu_lp];
 Mu_Angle=[Mu_AngleLN Mu_AngleN Mu_AngleZ Mu_AngleP Mu_AngleLP];
    




