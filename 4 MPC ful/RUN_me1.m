clear all;clc
ObserverModel_2area

sim('Icontrol.slx');

figure(1);plot(df1.time,df1.signals.values,':k','linewidth',2)
xlabel('time, s');ylabel('\Deltaf_1, p.u')
hold on

figure(2);plot(df2.time,df2.signals.values,':k','linewidth',2)
xlabel('time, s');ylabel('\Deltaf_2, p.u')
hold on

figure(3);plot(df1.time,dPtie.signals.values,':k','linewidth',2)
xlabel('time, s');ylabel('\DeltaP_t_i_e, p.u')
hold on

figure(4);plot(df1.time,ACE.signals.values(:,1),':k','linewidth',2)
xlabel('time, s');ylabel('ACE1, p.u')
hold on

figure(5);plot(df1.time,ACE.signals.values(:,2),':k','linewidth',2)
xlabel('time, s');ylabel('ACE2, p.u')
hold on
