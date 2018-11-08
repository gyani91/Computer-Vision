function [Out] = Img2Ary(Img)
S = size(Img);
tmp = reshape(Img, [S(1) * S(2), S(3)]);
Out = tmp';
end