function [x_lin T] = marginal_uniformization(x,porc,precision)

if nargin == 2, precision = 1000; end

p_aux = (porc/100)*abs(max(x)-min(x));
R_aux = linspace(min(x),max(x),sqrt(length(x))+1);

R = mean([R_aux(1:end-1); R_aux(2:end)]);

[p,R] = hist(x,R);   

delta_R = R(3)-R(2);
T.R_ant = [R(1)-delta_R R R(end)+delta_R];
T.p_ant = [0 p./(sum(p)*(R(4)-R(3))) 0];

C = cumsum(p);
N = max(C);

C = (1-1/N)*C/N;

incr_R = (R(2)-R(1))/2;

R = [min(x)-p_aux min(x)  R(1:end)+incr_R max(x)+p_aux+incr_R];
C = [0 1/N C 1]; 

Range_2 = linspace(R(1),R(end),precision);
C_2 = made_monotonic(interp1(R,C,Range_2));
C_2 = C_2/max(C_2);
x_lin = interp1(Range_2,C_2,x); 

T.C = C_2;
T.R = Range_2;
