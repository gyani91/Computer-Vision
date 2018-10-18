function f = fminGoldStandard(p, xy, XYZ, w)

%reassemble P
P = [p(1:4);p(5:8);p(9:12)];

%compute squared geometric error
sq_error=sqrt(sum((xy-P*XYZ).^2));
%sq_error=sum((xy-P*XYZ).^2);
%compute cost function value
f = sum(sq_error);
end