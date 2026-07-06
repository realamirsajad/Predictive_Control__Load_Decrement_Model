clear all;clc;format compact
close all
%*****************************************************
%*****************************************************
D1 = 0.015;M1 = 0.1667;R1 = 3   ;B1 = 0.425;Tg1 = 0.08;Tt1 = 0.40;
D2 = 0.016;M2 = 0.2017;R2 = 2.73;B2 = 0.425;Tg2 = 0.08;Tt2 = 0.44;

T12 = 0.2 * 2*pi;
dPL1 = 1;
dPL2 = 0;

% x1=[dPg1    dPm1        df1      dPtie   dPg2    dPm2      df2]
A = [-1/Tg1     0      -1/(R1*Tg1)   0       0       0        0
      1/Tt1   -1/Tt1       0         0       0       0        0
       0       1/M1     -D1/M1     -1/M1     0       0        0
       0        0         T12        0       0       0      -T12
       0        0          0         0     -1/Tg2    0      -1/(R2*Tg2)
       0        0          0         0      1/Tt2  -1/Tt2     0
       0        0          0        1/M2     0      1/M2   -D2/M2];

% u =[dPc1 dPc2 dPL1 dPL2]
B=[ 1/Tg1 0    0    0
    0     0    0    0
    0     0  -1/M1  0
    0     0    0    0
    0    1/Tg2 0    0
    0     0    0    0
    0     0    0   -1/M2];

C = [0 0 B1  1 0 0 0
     0 0 0  -1 0 0 B2];
D = [0 0 0 0
     0 0 0 0];
%*****************************************************
%*****************************************************
disp('==============================')
disp('Main  system:')
sys=ss(A,B,C,D)
disp('Poles:')
disp(eig(A))

figure(1)
pzmap(sys)
Yrange = get(gca,'Ylim');
Xrange = get(gca,'xlim');
%*****************************************************
%*****************************************************
disp('==============================')
Co=ctrb(A,B)';
disp('Controllability:')
disp(rank(Co));
disp('==============================')
Ob=obsv(A,C);
disp('Observability:')
disp(rank(Ob));
%---------------------------------------------------------.
t=0:0.01:30;
y=step(ss(A,B,C,D),t);
figure(2)
y=y(:,:,3);
plot(t,y(:,1),t,y(:,2))
xlabel('time')
ylabel('y')
title('Open loop response')
 grid on

 % Model reduction
[sysb,g,Ti,T] = balreal(sys)
elim = (g./sum(g))<0.005 %Least order
disp('==============================')
disp('Reduced model:')
rsys = modred(sysb,elim,'del')
[a,b,c,d]=ssdata(rsys);
disp('==============================')
disp('Dominant  poles:')
eig(a)
aa=Ti*A*T;
bb=Ti*B;
cc=C*T;
% %---------------------------------------------------------

figure(3)
pzmap(rsys)
axis([Xrange Yrange]);
y=step(rsys,t);
figure(4)
y=y(:,:,3);
plot(t,y(:,1),t,y(:,2))
xlabel('time')
ylabel('y')
title('Reduced Order Open loop response')
grid on

%---------------------------------------------------------.
Pole_obs=[-20 -21 -22 -23 -24 -25 -26 ];
disp('==============================')
disp('Observer gain (Pole placement):')
L=place(A',C',Pole_obs)'

%---------------------------------------------------------.
Pole_redobs=[-20 -21 -22 -23 -24];
disp('==============================')
disp('Reduced Observer gain (Pole placement):')
Lred=place(a',c',Pole_redobs)'



