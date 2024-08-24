boundary =[[2 5];[10 20];[30 40];[1 5];[1 6];[1 40];[40 1];[20 40];[20 1];[10 1];[10 10];[10 1]];

%{
boundary(boundary(:,1) == 1)= 0;
boundary(boundary(:,2) == 1)= 0;
boundary(boundary(:,1) == 1780)= 0;
boundary(boundary(:,2) == 1780)= 0;
%}

boundary(boundary==1)=0
boundary(boundary==40)=0