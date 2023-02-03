%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Property of Freescale
%  Freescale Confidential Proprietary
%  Freescale Copyright (C) 2014 All rights reserved
%  ----------------------------------------------------------------------------
%  $Source: $
%  $Date: $
%  $Revision: $
%  Target: Matlab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------
function [out_rel_pwr_index] = mConvertRelPowIndex( in_rel_pwr_index, flag )
if(flag)
    if (in_rel_pwr_index<=10000)
        out_rel_pwr_index = ceil(in_rel_pwr_index/10) - 600;
    end
    if ( (in_rel_pwr_index > 10000) & (in_rel_pwr_index <= 16000 ) )
        out_rel_pwr_index = ceil(in_rel_pwr_index/10) - 1200 - 1000;
    end
    if (in_rel_pwr_index > 16000)
        out_rel_pwr_index = ceil(in_rel_pwr_index/10) - 1600 + 400;
    end
else
    if ((in_rel_pwr_index <= 400 ) & (in_rel_pwr_index >= -600 ))
        out_rel_pwr_index = (in_rel_pwr_index + 600)*10;
    end
    if ( (in_rel_pwr_index < -600 ) & (in_rel_pwr_index >= -1200 ) )
        out_rel_pwr_index = (in_rel_pwr_index + 2200)*10;
    end
    if (in_rel_pwr_index > 400)
        out_rel_pwr_index = (in_rel_pwr_index + 1200)*10;
    end
end
end