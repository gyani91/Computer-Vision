function d = distPointLine(x1, x2, F)
    Fx1 = F*x1;
    Fx2 = F'*x2;
    d = DistancePointToLine(Fx2(1), Fx2(2), Fx2(3), x1) + ...
            DistancePointToLine(Fx1(1), Fx1(2), Fx1(3), x2);
end


