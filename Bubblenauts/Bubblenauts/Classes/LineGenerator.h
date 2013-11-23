//
//  LineGenerator.h
//  Bubblenauts
//
//  Created by Greggory Scherer on 11/16/13.
//
//

#ifndef __Bubblenauts__LineGenerator__

#define __Bubblenauts__LineGenerator__
#define Probability_To_Generate double
#define Entity char
#define StringRepresentation const char*
#define LineLength unsigned
#define EntityProbabilityDistribution std::map <Entity, Probability_To_Generate, std::less<Probability_To_Generate> >
#define Line std::list <Entity>
#define LineGroup std::queue <Line>

#include <iostream>
#include <queue>
#include <list>
#include <map>

namespace ProceduralGenerator
{

class LineGenerator 
{

public:
	LineGenerator(LineLength);
    StringRepresentation getNextLine();
    LineLength getLineLength();
    
private:
	EntityProbabilityDistribution primaryObjectsProbabilityDistribution;
    EntityProbabilityDistribution secondaryObjectsProbabilityDistribution;
    EntityProbabilityDistribution tertiaryObjectsProbabilityDistribution;
    LineGroup lastThreeLines;
    LineLength lineLength;
    bool checkIfBlocked(Entity entityName);
    bool requiredEntityBelow(Entity required, int position);
    
    Entity generatePrimaryEntity();
    Entity generateSecondaryEntity();
    Entity generateTertiaryEntity();
    Probability_To_Generate generateRandomNumber(int min, int max);
    virtual ~LineGenerator();
    LineGenerator();
    
};

}
#endif /* defined(__Bubblenauts__LineGenerator__) */
