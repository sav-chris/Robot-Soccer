%Plot resulting speed members

function [x,SpeedOutput]=MapOutput(Distance, Angle)

[LN_DOF,N_DOF,Z_DOF,P_DOF,LP_DOF]=GetOutputDegreeofFulfillment(Distance, Angle);

%constants

LN_min=-30;
LN_top=-20;
LN_max=-10;

N_min=-20;
N_top=-10;
N_max=0;

Z_min=-10;
Z_top=0;
Z_max=10;

P_min=0;
P_top=10;
P_max=20;

LP_min=10;
LP_top=20;
LP_max=30;

%PLOT

precision=1000;
x=linspace(-40,40,precision);

for i=1:precision;
    
    %Map LN set
    if LN_DOF==0
        LN(i)=0;
    else
        if x(i)<=LN_min
            LN(i)=0;
        elseif x(i)>LN_min && x(i)<=LN_top
            LN(i)=((x(i)-LN_min)*(1/(LN_top-LN_min)));
        elseif x(i)>LN_top && x(i)<LN_max
            LN(i)=1-((x(i)-LN_top)*(1/(LN_max-LN_top)));
        elseif x(i)>=LN_max
            LN(i)=0;
        end
        if LN(i)>LN_DOF
            LN(i)=LN_DOF;     %clips maximum level (maps the membership function)
        end
    end
    
    %Map N set
    if N_DOF==0
        N(i)=0;
    else
        if x(i)<=N_min
          N(i)=0;
        elseif x(i)>N_min && x(i)<=N_top
            N(i)=((x(i)-N_min)*(1/(N_top-N_min)));
        elseif x(i)>N_top && x(i)<N_max
            N(i)=1-((x(i)-N_top)*(1/(N_max-N_top)));
        elseif x(i)>=N_max
            N(i)=0;
        end
        if N(i)>N_DOF
            N(i)=N_DOF; %clips maximum level (maps the membership function)
        end
    end

    %Map Z set
    if Z_DOF==0
        Z(i)=0;
    else
        if x(i)<=Z_min
            Z(i)=0;
        elseif x(i)>Z_min && x(i)<=Z_top
            Z(i)=((x(i)-Z_min)*(1/(Z_top-Z_min)));
        elseif x(i)>Z_top && x(i)<Z_max
            Z(i)=1-((x(i)-Z_top)*(1/(Z_max-Z_top)));
        elseif x(i)>=Z_max
            Z(i)=0;
        end
        if Z(i)>Z_DOF;
            Z(i)=Z_DOF; %clips maximun level
        end
    end

    %Map P set
    if P_DOF==0
        P(i)=0;
    else
        if x(i)<=P_min
            P(i)=0;
        elseif x(i)>P_min && x(i)<=P_top
            P(i)=((x(i)-P_min)*(1/(P_top-P_min)));
        elseif x(i)>P_top && x(i)<P_max
            P(i)=1-((x(i)-P_top)*(1/(P_max-P_top)));
        elseif x(i)>=P_max
            P(i)=0;
        end
        if P(i)>P_DOF
            P(i)=P_DOF; %clips maximum level
        end
    end

    %Map LP set
    if LP_DOF==0
        LP(i)=0;
    else
       if x(i)<=LP_min
           LP(i)=0;
       elseif x(i)>LP_min && x(i)<=LP_top
           LP(i)=((x(i)-LP_min)*(1/(LP_top-LP_min)));
       elseif x(i)>LP_top && x(i)<LP_max
           LP(i)=1-((x(i)-LP_top)*(1/(LP_max-LP_top)));
       elseif x(i)>=LP_max
           LP(i)=0;
       end
       if LP(i)>LP_DOF
           LP(i)=LP_DOF;    %clips maximum level
       end
    end
clear Sets;
Sets=[LN(i) N(i) Z(i) P(i) LP(i)];
SpeedOutput(i)=max(Sets);    
end

plot(x,LP,'g');
axis([-40 40 -.1 1.1]);
hold on;
plot(x,P,'r');
plot(x,Z);
plot(x,N,'m');
plot(x,LN,'c');
plot(x,SpeedOutput,'k');
hold off;