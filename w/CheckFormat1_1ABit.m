
function [dciFormat0RawLen,dciFormat1ALen] = CheckFormat1_1ABit(crntiScramb,N_RB, Duplexing_Mode, Subframe_Assignment, varargin)

AMBIG_SIZES = [12, 14, 16, 20, 24, 26, 32, 40, 44, 56 ];
totalBits = 0;
i = 0;
RAT_bit = 1;

%TDD specific bits
DAI_bits = 2;
UL_index_bits=2;
HARQ_proc_add_bit = 1;
TDD_bits = 0;


%% Processing DCI length for DCI format 0
if Duplexing_Mode == 1
    %FDD mode
    TDD_bits = 0;
elseif Duplexing_Mode == 0
    %TDD mode
    if Subframe_Assignment == 0
        TDD_bits = UL_index_bits;
    else
        TDD_bits = DAI_bits;
    end
end

%Taken from above in order to work for both RAT0 and RAT1 DCI0
numRBAssignBits = ceil(log2(N_RB*(N_RB+1)/2));

%If an external RB_assign Bits has been given overwrite the old one
if(nargin == 5)
    numRBAssignBits = varargin{1};
end

%/* Compute the DCI format-0 length */
dciFormat0RawLen = 14 + numRBAssignBits + TDD_bits + RAT_bit;


%% Processing length for DCI format 1
if Duplexing_Mode == 1
    %FDD mode
    TDD_bits = 0;
elseif Duplexing_Mode == 0
    %TDD mode
    TDD_bits = DAI_bits + HARQ_proc_add_bit;
end

%/* Compute the DCI format-1A length */
%if(crntiScramb == 1)
%    totalBits = 12 + numRBAssignBits;
%    dciFormat1ALen = 13 + totalBits;
%else
    totalBits = 15 + TDD_bits;
    dciFormat1ALen =  numRBAssignBits + totalBits;
%end

 %/*  If computed length of format-1A is having ambiguous size,
 % increment the length by one                                */
 DCI0_adjusted = 0;
 DCI1A_adjusted = 0;

for  i = 1:10
    if(AMBIG_SIZES(i) == dciFormat1ALen)&&(DCI1A_adjusted == 0)
        dciFormat1ALen = dciFormat1ALen + 1;
        DCI1A_adjusted = 1;
    end

    if(AMBIG_SIZES(i) == dciFormat0RawLen)&&(DCI0_adjusted == 0)
        dciFormat0RawLen = dciFormat0RawLen + 1;
        DCI0_adjusted = 1;
    end
end

%/* Check whether the format-0 length is greater than format-1A
 % length or not. If so assign format-0 length to format-1A length */
if(dciFormat1ALen < dciFormat0RawLen)
    dciFormat1ALen = dciFormat0RawLen;
elseif(dciFormat0RawLen <dciFormat1ALen)
    dciFormat0RawLen = dciFormat1ALen;
end
end


