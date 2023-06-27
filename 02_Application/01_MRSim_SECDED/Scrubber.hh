#ifndef __SCRUBBER_HH__
#define __SCRUBBER_HH__

#include "DomainGroup.hh"

class Scrubber {
public:
    Scrubber() {}
public:
    virtual void scrub(DomainGroup *dg, double hrs) = 0;
};

class NoScrubber : public Scrubber {
public:
    NoScrubber() {}

    void scrub(DomainGroup *dg, double hrs) { return; }
};

class PeriodicScrubber : public Scrubber {
public:
    PeriodicScrubber(double _period) : period(_period), prevScrubSection(0) { }

    void scrub(DomainGroup *dg, double hrs) {
        int curScrubSection = (int) hrs / period;
        if (curScrubSection != prevScrubSection) {
            dg->scrub();
            prevScrubSection = curScrubSection;
        }
    }
protected:
    double period;
    int prevScrubSection;
};

#endif /* __SCRUBBER_HH__ */
