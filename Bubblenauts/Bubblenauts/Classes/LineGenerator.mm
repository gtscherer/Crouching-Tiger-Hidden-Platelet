//
//  LineGenerator.cpp
//  Bubblenauts
//
//  Created by Greggory Scherer on 11/16/13.
//
//
#include "LineGenerator.h"
#include "Entity.h"
#include "EntityManager.h"
#include <queue>
#include <list>
#include <map>
#include <stdlib.h>
#include <time.h>

#define Probability_To_Generate double
#define Line_Length unsigned
#define Entity_Name int
#define Line std::list <Entity>
#define LineGroup std::queue <Line>

#define Air 0
#define Platform 1
#define Bubble 2
#define Suds 3
#define Spike 4
#define Fan 5

//Primary objects -> they will be generated on first pass. 
//Generation of other elements depends on their location
#define AirProbability 0.9
#define SpikeUnderPlatformProbability 0.1 //Primary and Tertiary, Forces platform


//Secondary Objects -> Generated on second pass
//Depends on location of basic objects
#define PlatformProbability 0.4 //Requires air, actual probability 0.4 * 0.9 = 0.36
#define BubbleProbability 0.2 //Requires air, actual probability 0.9 * 0.2 = 0.18
#define SudsProbability 0.1 //Secondary & Tertiary, generation depends on air and suds nearby. Actual probability 0.9 * 0.1 = 0.09

//Tertiary Objects -> Generated on third pass
#define SpikeAbovePlatformProbability 0.1 //Requires platform
#define SudGroupingProbability 0.8 //Requires adjacent suds and air, actual probability 0.9 * 0.1 * 0.8 = 0.072
#define FanProbability 0.8 //Requires platform, probability 0.7 * 0.4 * 0.9 = 0.252


namespace ProceduralGenerator
{

	LineGenerator::LineGenerator(Line_Length lineLength, EntityManager& entityManager) : lineLength(lineLength), entityManager(entityManager)
	{
		this->primaryObjectsProbabilityDistribution[Air] = AirProbability;
        this->primaryObjectsProbabilityDistribution[Spike] = SpikeUnderPlatformProbability;
        
		this->secondaryObjectsProbabilityDistribution[Platform] = PlatformProbability;
        this->secondaryObjectsProbabilityDistribution[Bubble] = BubbleProbability;
        this->secondaryObjectsProbabilityDistribution[Suds] = SudsProbability;
        
		this->tertiaryObjectsProbabilityDistribution[Spike] = SpikeAbovePlatformProbability;
        this->tertiaryObjectsProbabilityDistribution[Suds] = SudGroupingProbability;
        this->tertiaryObjectsProbabilityDistribution[Fan] = FanProbability;
		//Initialize random number generator with seed once
        std::srand(time(0));
	}
    
    LineGenerator::~LineGenerator() {}
    
	double LineGenerator::generateRandomNumber(int min, int max)
	{
		return static_cast<double>((std::rand()) / (max + 1)) * (max - min + 1) + min;
	}
	Entity_Name LineGenerator::generatePrimaryEntity()
	{

	}
	Entity_Name LineGenerator::generateSecondaryEntity()
	{

	}
	Entity_Name LineGenerator::generateTertiaryEntity()
	{

	}
	Line LineGenerator::getNextLine(){

	}

	Entity* LineGenerator::initializeEntityObject(Entity_Name entityName)
	{
		switch(entityName)
		{
			case Air:
				break;
			case Platform:
				break;
			case Bubble:
				break;
			case Suds:
				break;
			case Spike:
				break;
			case Fan:
				break;
		}
	}
}