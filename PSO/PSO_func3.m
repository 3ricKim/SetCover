function [gbest,gbestval,cg_curve,sol_best]= PSO_func3(mm,Max_Gen,Max_FES,Particle_Number)
sol_best=zeros(1,size(mm,1));
universe=unique(mm);
lenofsol=length(mm(:,1));
VRmin=0.23501; % Minimum percentage of 1s
VRmax=2; % Maximum percentage of 1s
rand('state',sum(100*clock));
me=Max_Gen; %Number of generations
ps=Particle_Number; %Number of Particles
D=1;    %Dimensions 
         % For any dataset dimension is 1 as we hv taken percentage of 1s
         % in sequence
cc=[2 2];   %acceleration constants
iwt=0.5.*ones(1,me);    %Inertia Weight

%Boundary Check
if length(VRmin)==1
    VRmin=repmat(VRmin,1,D);
    VRmax=repmat(VRmax,1,D);
end
mv=0.5*(VRmax-VRmin);
VRmin=repmat(VRmin,ps,1);
VRmax=repmat(VRmax,ps,1);
Vmin=repmat(-mv,ps,1);
Vmax=-Vmin;
pos=VRmin+(VRmax-VRmin).*rand(ps,1);




for i=1:ps
[e(i,1),sol]=evaluate3(pos(i,:),lenofsol,mm,universe);  % I hv returned sol as to keep a copy of sequence
end

fitcount=ps;
vel=Vmin+2.*Vmax.*rand(ps,D);%initialize the velocity of the particles
pbest=pos;
pbestval=e; %initialize the pbest and the pbest's fitness value
[gbestval,gbestid]=min(pbestval);
gbest=pbest(gbestid,:);%initialize the gbest and the gbest's fitness value
gbestrep=repmat(gbest,ps,1);
g_res(1)=gbestval;

tmp1=abs(repmat(gbest,ps,1)-pos)+abs(pbest-pos);
temp1=ones(ps,1);
temp2=ones(ps,1);

for kkk=1:D
    temp1=temp1.*tmp1(:,kkk);
    temp2=temp2.*(max(pbest(:,kkk))-min(pbest(:,kkk)));
end


i=1;
while i<me && fitcount<=Max_FES
i=i+1;
    for k=1:ps
    %Updating the Velocities of particles
    aa(k,:)=cc(1).*rand(1,D).*(pbest(k,:)-pos(k,:))+cc(2).*rand(1,D).*(gbest-pos(k,:));
    vel(k,:)=iwt(i).*vel(k,:)+aa(k,:);
    vel(k,:)=(vel(k,:)>mv).*mv+(vel(k,:)<=mv).*vel(k,:); 
    vel(k,:)=(vel(k,:)<(-mv)).*(-mv)+(vel(k,:)>=(-mv)).*vel(k,:);
    %Updating Positions of particles
    pos(k,:)=pos(k,:)+vel(k,:); 
    pos(k,:)=((pos(k,:)>=VRmin(1,:))&(pos(k,:)<=VRmax(1,:))).*pos(k,:)...
        +(pos(k,:)<VRmin(1,:)).*(VRmin(1,:)+0.25.*(VRmax(1,:)-VRmin(1,:)).*rand(1,D))+(pos(k,:)>VRmax(1,:)).*(VRmax(1,:)-0.25.*(VRmax(1,:)-VRmin(1,:)).*rand(1,D));
    %Function Evaluation
    
    [e(k,1),sol]=evaluate3(pos(k,:),lenofsol,mm,universe);
    tmp=(pbestval(k)>e(k));
    temp=repmat(tmp,1,D);
    if pbestval(k)>e(k)
        pbest(k,:)=pos(k,:);
        pbestval(k)=e(k);
    end
%     pbest(k,:)=temp.*pbest(k,:)+(1-temp).*pos(k,:);
%     pbestval(k)=tmp.*pbestval(k)+(1-tmp).*e(k); %updating the personal best
    if pbestval(k)<gbestval
        gbest=pbest(k,:);
        gbestval=pbestval(k);
        gbestrep=repmat(gbest,ps,1);    %updating the global best
        sol_best=sol;
    end
    cg_curve(fitcount-ps+1)=gbestval;    %Storing current gbest for convergence curve
    fitcount=fitcount+1;
    if fitcount>Max_FES
            break;
    end
    end

if fitcount>Max_FES
    break;
end

if (i==me)&&(fitcount<=Max_FES)
    i=i-1;
end

end