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
#define Line_Length unsigned
#define Entity_Name int
#define EntityProbabilityDistribution std::map <Entity_Name, Probability_To_Generate, std::less<Probability_To_Generate> >
#define Line std::list <Entity>
#define LineGroup std::queue <Line>

#include <iostream>
#include "Entity.h"
#include "EntityManager.h" 
#include <queue>
#include <list>
#include <map>

namespace ProceduralGenerator
{

class LineGenerator 
{

public:
	LineGenerator(Line_Length, EntityManager&);
    Line getNextLine();
    EntityProbabilityDistribution getPrimaryObjectsProbabilityDistribution();
    EntityProbabilityDistribution getSecondaryObjectsProbabilityDistribution();
    EntityProbabilityDistribution getTertiaryObjectsProbabilityDistribution();

private:
	EntityProbabilityDistribution primaryObjectsProbabilityDistribution;
    EntityProbabilityDistribution secondaryObjectsProbabilityDistribution;
    EntityProbabilityDistribution tertiaryObjectsProbabilityDistribution;
    LineGroup lastThreeLines;
    Line_Length lineLength;
    EntityManager& entityManager;

    Entity initializeEntityObject(Entity_Name);
    Entity_Name generatePrimaryEntity();
    Entity_Name generateSecondaryEntity();
    Entity_Name generateTertiaryEntity();
    double generateRandomNumber(int min, int max);
    virtual ~LineGenerator();
    LineGenerator();
    
};

}
#endif /* defined(__Bubblenauts__LineGenerator__) */
