function [ Out ] = Ary2Img( Ary, Size )
    Out = reshape(Ary', Size);
end