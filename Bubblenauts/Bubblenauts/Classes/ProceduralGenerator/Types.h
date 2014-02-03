//
//  Types.h
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/3/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#ifndef __Bubblenauts__Types__
#define __Bubblenauts__Types__


#include "Rule.h"
#include "LineGeneratorEntity.h"

#include <iostream>
namespace ProceduralGenerator{
    class LineGeneratorEntity;
    class Rule;
    
    typedef ProceduralGenerator::LineGeneratorEntity Entity;
    typedef std::list<ProceduralGenerator::Rule> Rules;
    typedef std::list<ProceduralGenerator::Rule*> RulePointerList;
    typedef std::pair<int, int> Integer_Pair;
    typedef std::pair<double, double> Double_Pair;
    typedef std::list< Double_Pair > ScaleFactors;
}
#endif /* defined(__Bubblenauts__Types__) */
