function [fccc, fcuc ,fy] = fcstress1(e)

%{
if e < 0
    fc = 0;
elseif e < 0.002
    fc = (17*1.641631*e/0.002)/(0.641631 + (e/0.002)^1641631);
elseif e >= 0.002
    fc = 17 - 0.15*17*(e-0.002)/0.0018;
end
%}

%e = 0:1e-4:0.015;
%Confined
if e< 0 
    fccc = 0;
elseif e > 0.002384 && e <= 0.0139
    fccc = 17.6529 - (2.647935*(e-0.002384))/0.002156;
elseif e > 0.0139
    fccc = 3.53058;
else
    fccc = (26.7633*e/0.002384)/(0.516251 + (e/0.002384)^1.516251);
end


%%Unconfined
if e< 0
    fcuc = 0;
elseif e >=0.002 && e <= 0.0116
    fcuc = 17 - (2.55*(e-0.002))/0.0018;
elseif e > 0.0116
    fcuc = 3.4;
else 
    fcuc = (27.907727*e/0.002)/(0.641631 + (e/0.002)^1.641631);
end


%e = -0.12:1e-4:0.12;
%%Steel
if abs(e)<= 0.002381
    fy = 210000*e;
else
    fy = sign(e)*(sign(e)*850.2024*(e-0.002381)+500);
end

end

%{
plot(e,fuc)
hold on
plot(e,fcc)
hold off
legend ('fuc', 'fcc')

plot(e,fy)
%}