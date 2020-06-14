function []=ploting()
clear all;
close all;
clc
N=3000;
FC=zeros(N,1);
FY=zeros(N,1);
E=zeros(N,1);
%fye1=[0 0; .00144 288.7; .00163 306.7; .00192 324.8; .00241 342.8; 0.00276 351.8; .0038 360.9; .05 360.9];%stress strain relation of steel
fck=25;
fcdash=25;
FCUC=zeros(N,1);
for a=1:N
    e= 0.00001*(-N/2+a);
    E(a,1)=e;
    
    %[fc,fy]= fcstress2(e,fck,fye1);
    %[fc,fy] = fcstress(e,fcdash);
    [fc, fuc ,fy] = fcstress1(e);
    FC(a,1)=fc;
    FCUC(a,1)=fuc;
    FY(a,1)=fy;
end


%plot(E,FC); ylabel('Confined stress (MPa)'); xlabel('strain'); 
figure;
plot(E,FY); ylabel('Steel Stress (MPa)'); xlabel('strain');
figure;
plot(E,FCUC,E,FC); ylabel('Stress (MPa)'); xlabel('strain'); 
xlim([0,.015]);legend('UNCONFINED Stress','CONFINED Stress')  
       legend('Location','northeast')
end