clear
close all
% we will find M and Phi here
D=500; ccover= 50;      %clear cover
fck=25;
Cn=400*ones(D,1);       % total section, considering no confining effect
Cc= [zeros(ccover,1);300*ones(D-100,1);zeros(ccover,1)];  % confined concrete empty from top and bottom
Uc=Cn-Cc;               % unconfined part of section
ss=zeros(D,1);
Pu=[800e3];            % given axial load conditions can be put in this

ploting();              % ploting stress strain curve of confined , unconfined concrete and steel
dd=1:D;
dbD = 66;               % effective cover
barloc = [3,dbD; 2,D/2; 3,(D-dbD)]; % no of bars, and their location from top

%dividing the steel bar into stips ,
sd=(16);                % bar size
yy=-sd/2:1:sd/2;        % bar slices 
x=zeros(length(yy),1);
for n=1:length(yy)
    y=yy(n);
    x(n)=sqrt((sd/2)^2 -y^2);%circle property
end
bar1= 2*x; % x was half thickness of bar strips, we got from circle properties, so we double it now
bar12=(pi*sd^2 /4)/(sum(bar1))* bar1; % bar area was little reduced after strip cutting, so we take this factor


% simulate steel , copying bar strips at all required  locations 
for a=1:length(barloc)
    
for j=1:length(bar12);
    
   ss(barloc(a,2)+yy(j))=  ss(barloc(a,2)+yy(j))+barloc(a,1)*bar12(j);

end
end

% correct Uc and Cn
Uc=Uc-ss;
Cn=Cn-ss; % no confining effect in whole Cn section


%% simulate axial force and moments for confining effect
r=80;

forces=length(Pu);
MC=zeros(forces,r); M2=0; P1=0;
Phi=zeros(1,r);
P=zeros(forces,r); 
for z=1:forces
 ep=0; n=0; c=0; d=0; a=1;
 ee=zeros(D,r); % for check
while a<=r;
    
    for j=1:length(dd) 
        y=dd(j);
        
   
                e=ep-(y-(.5)*D)*a*.000002;      
             
         ee(y,a)=e; % will be used for calculating phi
    %[fc,fy]= fcstress2(e,fck,fye1); %finding fc and fy wrt e
    [fcc, fuc ,fy] = fcstress1(e);    % confined, unconfined and steel stress
    
      % finding M and Phi
        
    pstrip=fy*ss(j) +fuc*Uc(j) + fcc*Cc(j);
    P1=P1+pstrip;
    
    M2=M2+ pstrip*(D/2-y);
    end
    if abs(P1-Pu(z))<1000
    MC(z,a)=M2;
    P(z,a)=P1;
    Phi(1,a)= (ee(1,a)-ee(D,a))/D;
    a=a+1
    n=0; c=0; d=0;
    
    elseif P1< Pu(z)
    ep=ep+.0001/(1+.2*(c*d));
   M2=0; P1=0;
    
    c=c+1; % c and d are a part of small trick to achive acuuracy with less no of iteration,
            %c and d will reduce iteration step if it occilating up and down wrt target P
    
    else
        ep=ep - .0001/(1+.2*(c*d));
       M2=0; P1=0;
   
d=d+1;
    end

end

figure;
plot([0,Phi(1,:)],[0,MC(z,:)])
ylabel('MOMENT "N-mm"'); xlabel('PHI "per-mm"');   
end
%M=[zeros(3,1),M];
Phi=[zeros(1,1),Phi];
