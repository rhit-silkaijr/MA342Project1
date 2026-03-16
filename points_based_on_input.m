function [P_o] = points_based_on_input(A,n)
% points_based_on_input
% Takes in a value A, an m x 2 vector of points describing the wing,
% with endpoints at 0, 1, and 0
% Note A must have the descriptive line truncated in preprocessing
% And n, the number of panels desired
% Returns P_o, the points detailing each panel

%n = 7;
%P = [1 .95 .9 .8 .7 .6 .5 .4 .3 .25 .2 .15 .1 .075 .05 .025 .0125 0; .0019 .0155 .0281 .0508 .0702 .0865 .0989 .1071 .1088 .1065 .1015 .0934 .0805 .0717 .0603 .0445 .0328 0.000]';
%P2 = [0 .0125 .025 .05 .075 .1 .15 .2 .25 .3 .4 .5 .6 .7 .8 .9 .95 1; 0 -.0245 -.0344 -.0468 -.0548 -.0603 -.0674 -.0709 -.0718 -.0712 -.0671 -.0599 -.0504 -.0397 -.0280 -.0153 -.0087 -.0019]';

P1 = A(1:ceil(length(A)/2),:);
P2 = A(ceil(length(A)/2):length(A),:);

x = P1(:,1);
y = P1(:,2);
xx = 0:.01:1;
x2 = P2(:,1);
y2 = P2(:,2);

% yy = spline(x,y,xx);
% yy2 = spline(x2,y2,xx);

% plot(x,y,'o',xx,yy);
% 
% hold on
% 
% plot(x2,y2,'g',xx,yy2);
% 
% hold on

P_o = zeros(n-1,2);
%P_o = zeros(n,2);
if(mod(n,2) == 1)
    P_o(ceil(n/2),1) = 1;
    P_o(ceil(n/2),2) = 0;
    for i=1:(n-1)/2
        x_val=2*i/(n+1);
        P_o(i,1) = x_val;
        P_o(i,2) = spline(x,y,x_val);
    
        P_o(n-i+1,1) = x_val;
        P_o(n-i+1,2) = spline(x2,y2,x_val);
    end
else
    for i=1:n/2
        x_val=(i-.5)/(n/2);
        P_o(i,1) = x_val;
        P_o(i,2) = spline(x,y,x_val);
    
        P_o(n-i+1,1) = x_val;
        P_o(n-i+1,2) = spline(x2,y2,x_val);
    end
end
P_o = cat(1,[0 0],P_o);
