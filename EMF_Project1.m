clear;
clc;

%Initializations
ep = 8.856e-12 ; %epsilon
appV = 10; %Applied voltage total
h= 1; %height of capacitor
N=20; % Number of unknown points (arbitrary)
deltaX = 0.33333; %Distance between each point on x-axis
deltaY = deltaX; %These are equal since this is a square
V=zeros(N,N); %Generates array NxN of "0"
E=zeros(N,N); %Generates array NxN of "0"
V(1,:)=10; V(:,end)=10; %Sets Boundary Conditions
E(1,:)=10; E(:,end)=10; %Sets Boundary Conditions
temp_E=0;%place holder
Q=0; %inizalize Q

%Loop determines the Electric Potential in Domain and Constant Field Energy
for k=1:200 %number of iterations
    for p=2:N-1
       for r=2:N-1
           V(p,r)=(V(p+1,r)+V(p-1,r)+V(p,r+1)+V(p,r-1))./4;
           EAx = ((-V(p+1,r))-V(p-1,r))/(2*deltaX);
           EAy = (-V(p,r+1)-V(p,r-1))/(2*deltaY);
           E(p,r)= EAx + EAy;
           temp_E=E(p,r)^2*deltaX*deltaY+temp_E; %finds the summation
          Q= E(p,r)*deltaX*deltaY*ep+Q; %gives us Q, the charge
          
          %Tests V for convergence
          %V_Converg(k)=norm(V);
       end
    end
end

%Plots a contour map of the Electric Potential for V
subplot(1,2,1);
contour(V,10,'ShowText','on')
set(gca,'yDir','reverse');

%Plots Electric Field
subplot(1,2,2);
[Ex,Ey]=gradient(-V);
quiver(Ex,Ey)
set(gca,'yDir','reverse');

w=ep*temp_E %engergy stored

C = (2*w) / (appV^2) %AppV = 10V


