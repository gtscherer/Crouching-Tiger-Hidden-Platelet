//
//  LineGenerator.cpp
//  Bubblenauts
//
//  Created by Greggory Scherer on 11/16/13.
//
//
#include "LineGenerator.h"
#include <queue>
#include <list>
#include <map>
#include <stdlib.h>
#include <time.h>

#define NotGenerated 'x'
#define Air '0'
#define Platform '1'
#define Bubble '2'
#define Suds '3'
#define Spike '4'
#define Fan '5'

//Generated objects can block space for up to three following generated
#define FirstLevelVerticalInvalidSpace 'i'
#define SecondLevelVerticalInvalidSpace 'j'
#define ThirdLevelVerticalInvalidSpace 'k'

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

using namespace ProceduralGenerator;

LineGenerator::LineGenerator(LineLength lineLength) : lineLength(lineLength)
{
    this->primaryObjectsProbabilityDistribution[Air] = AirProbability;
    //this->primaryObjectsProbabilityDistribution[Spike] = SpikeUnderPlatformProbability;

    this->secondaryObjectsProbabilityDistribution[Platform] = PlatformProbability;
    this->secondaryObjectsProbabilityDistribution[Bubble] = BubbleProbability;
    //this->secondaryObjectsProbabilityDistribution[Suds] = SudsProbability;

    //this->tertiaryObjectsProbabilityDistribution[Spike] = SpikeAbovePlatformProbability;
    //this->tertiaryObjectsProbabilityDistribution[Suds] = SudGroupingProbability;
    //this->tertiaryObjectsProbabilityDistribution[Fan] = FanProbability;

    //Initialize random number generator with seed once
    std::srand(time(0));
}

LineGenerator::~LineGenerator() {}

bool LineGenerator::checkIfBlocked(char entityName)
{
    switch(entityName)
    {
        case ThirdLevelVerticalInvalidSpace: return false;
        case SecondLevelVerticalInvalidSpace: return false;
        case FirstLevelVerticalInvalidSpace: return false;
        default:
            return true;
    }
}

bool LineGenerator::requiredEntityBelow(char required, int position)
{
    if(this->previousLine.size() > 0)
    {
        std::list<Entity>::iterator previousLineEntity = this->previousLine.begin();
        for(int pos = 0; pos < position; ++pos, ++previousLineEntity);
        if(*previousLineEntity == required) return true;
        else return false;
    }
    else return false;
}

StringRepresentation LineGenerator::getNextLine()
{
    Line workingLine;
    std::list<Probability_To_Generate> primaryProbabilityValues;
    std::list<Probability_To_Generate> secondaryProbabilityValues;
    std::list<Probability_To_Generate> tertiaryProbabilityValues;

    //Initialize line
    //Generate list of random numbers between zero and one

    for(int linePosition = 0; linePosition < this->lineLength; ++linePosition){
        workingLine.push_back(NotGenerated);
        primaryProbabilityValues.push_back(this->generateRandomNumber(0, 1));
        secondaryProbabilityValues.push_back(this->generateRandomNumber(0, 1));
        tertiaryProbabilityValues.push_back(this->generateRandomNumber(0, 1));
    }
    
    std::list<Entity>::iterator linePosition = workingLine.begin();
    //Check for blocking entities from below
    if(this->previousLine.size() > 0){
        Line previousLine = this->previousLine;
        for(Entity object : previousLine){
            if(object == ThirdLevelVerticalInvalidSpace) *linePosition = SecondLevelVerticalInvalidSpace;
            else if(object == SecondLevelVerticalInvalidSpace) *linePosition = FirstLevelVerticalInvalidSpace;
            else if(object == FirstLevelVerticalInvalidSpace) *linePosition = NotGenerated;
            else if(object == Platform || object == Spike || object == Fan) *linePosition = SecondLevelVerticalInvalidSpace;
            else if(object == Bubble || object == Suds) *linePosition = ThirdLevelVerticalInvalidSpace;
        }
        ++linePosition;
    }
    

    //Assigning character-represented-entities to array representing line being built
    //First pass
    linePosition = workingLine.begin();
    for(Probability_To_Generate probability : primaryProbabilityValues)
    {
        if(this->checkIfBlocked(*linePosition))
        {
            for(auto EntityProbabilityPair : this->primaryObjectsProbabilityDistribution)
            {
                if(probability < EntityProbabilityPair.second) *linePosition = EntityProbabilityPair.first;
            }
        }
        ++linePosition;
    }

    // Ensure every position has been assigned an entity -> Default = Air
    for(Entity & linePosition : workingLine) if(linePosition == NotGenerated) linePosition = Air;

    // Second Pass
    linePosition = workingLine.begin();
    int currentLinePosition = 0;
    for(Probability_To_Generate probability : primaryProbabilityValues)
    {
        if(this->checkIfBlocked(*linePosition))
        {
            if(*linePosition == Air){
                for(auto EntityProbabilityPair : this->secondaryObjectsProbabilityDistribution)
                {
                    if(probability < EntityProbabilityPair.second)
                    {
                        switch(EntityProbabilityPair.first)
                        {
                            case Fan:
                                if(this->requiredEntityBelow(Platform, currentLinePosition)) *linePosition = EntityProbabilityPair.first;
                                else *linePosition = Air;
                                break;
                            case Spike:
                                if(this->requiredEntityBelow(Platform, currentLinePosition)) *linePosition = EntityProbabilityPair.first;
                                else *linePosition = Air;
                                break;
                            default:
                                *linePosition = EntityProbabilityPair.first;
                        }
                    }
                }
            }
        }
        ++currentLinePosition;
        ++linePosition;
    }
    
    //Insert third pass here
    
    {
        
    }
    
    this->previousLine = workingLine;
    
    //Clean up -> make sure everything is a generatable entity
    for(Entity& entity: workingLine)
    {
        switch(entity)
        {
            case FirstLevelVerticalInvalidSpace:
            case SecondLevelVerticalInvalidSpace:
            case ThirdLevelVerticalInvalidSpace:
                entity = Air;
                break;
            default:
                continue;
        }
    }
    
    //Convert Line List to string..
    std::string stringRepresentation;
    for(Entity entity : workingLine)
    {
        stringRepresentation += entity;
    }
    
    return stringRepresentation.data();

}

Probability_To_Generate LineGenerator::generateRandomNumber(int min, int max)
{
    return static_cast<double>((std::rand()) / (max + 1)) * (max - min + 1) + min;
}


