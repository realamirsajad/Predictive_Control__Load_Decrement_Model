clear all;clc
ObserverModel_2area;

uiopen('MPCcontrol1.slx',1)
sim('MPCcontrol1.slx');


figure(1);plot(df1.time,df1.signals.values,':k','linewidth',1.5)
xlabel('time, s');ylabel('\Deltaf_1, p.u')
hold on

figure(2);plot(df2.time,df2.signals.values,':k','linewidth',1.5)
xlabel('time, s');ylabel('\Deltaf_2, p.u')
hold on

figure(3);plot(df1.time,dPtie.signals.values,':k','linewidth',1.5)
xlabel('time, s');ylabel('\DeltaP_t_i_e, p.u')
hold on

figure(4);plot(df1.time,ACE.signals.values(:,1),':k','linewidth',1.5)
xlabel('time, s');ylabel('ACE1, p.u')
hold on

figure(5);plot(df1.time,ACE.signals.values(:,2),':k','linewidth',1.5)
xlabel('time, s');ylabel('ACE2, p.u')
hold on
