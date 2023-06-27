#include "prior.hh"
#include "hsiao.hh"
#include "FaultDomain.hh"

//------------------------------------------------------------------------------
// SEC-DED on 72-bit interface
//------------------------------------------------------------------------------
SECDED72b::SECDED72b() : ECC(LINEAR) {
    configList.push_back({0, 0, new Hsiao("SEC-DED (Hsiao)\t18\t4\t", 72, 8)});
}