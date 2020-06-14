function [fccc, fcuc ,fy] = fcstress1(e)

%{
if e < 0
    fc = 0;
elseif e < 0.002
    fc = (25*1.641631*e/0.002)/(0.641631 + (e/0.002)^1641631);
elseif e >= 0.002
    fc = 17 - 0.15*17*(e-0.002)/0.0018;
end
%}

%e = 0:1e-4:0.015;
%Confined
if e< 0 
    fccc = 0;
elseif e > 0.002254 && e <= 0.01425
    fccc = 25.6345 - (25.6345*0.15*(e-0.002254))/(0.0045-0.002254);
elseif e > 0.01425
    fccc = 5.12689;
else
    fccc = (25.6345*2.09644*e/0.002254)/(1.09644 + (e/0.002254)^2.09644);
end


%%Unconfined
if e< 0 || e>0.004
    fcuc = 0;
elseif e >=0.002
    fcuc = 25 - (25*0.15*(e-0.002))/0.0018;
else 
    fcuc = (25*2.35172*e/0.002)/(1.35172 + (e/0.002)^2.35172);
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