%-----------------------------------------------------%
function Array = CreateBitArray(value,bits)

%Mask It
mask = uint32(2^bits -1);
value = bitand(value,mask);

Array = [];

%Create Array
for i = 1:bits
    Array = [bitand(value,1) Array];
    value = bitshift_wrap(value,-1);
end