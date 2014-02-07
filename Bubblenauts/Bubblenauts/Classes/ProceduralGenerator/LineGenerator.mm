#include "LineGenerator.h"
#include <time.h>
#include <string>

#define NotGenerated 'x'
#define Air '0'
#define Platform '1'
#define Bubble '2'
#define Suds '3'
#define Spike '4'
#define Fan '5'

using namespace ProceduralGenerator;
using namespace std;

list<Rule> RuleList::getRules()
{
	return this->rules;
}

int RuleList::size()
{
    return this->rules.size();
}

Rules RuleList::getExclusions()
{
	Rules exclusions;
	for(Rule rule : this->rules) if(rule.getRuleType() == Exclude) exclusions.push_back(rule);
	return exclusions;
}

Rules RuleList::getForceGenerate()
{
	Rules forceGenerate;
	for(Rule rule : this->rules) if(rule.getRuleType() == Force) forceGenerate.push_back(rule);
	return forceGenerate;
}


void MasterRuleQueue::addRule(ProceduralGenerator::Rule rule, int column_number, int height)
{
    int columnSize = this->size(column_number);
    if(columnSize != -1)
    {
        if(height <= columnSize)
        {
            auto queueIterator = this->ruleQueue.begin();
            for(int i = 0; i < height; ++i, ++queueIterator);
            //*queueIterator
        }
    }
    

}

int MasterRuleQueue::size()
{
    return this->ruleQueue.size();
}

int MasterRuleQueue::size(int index)
{
    if(index < this->size()) return this->ruleQueue[index].size();
    else return -1;
}

RuleList MasterRuleQueue::peekRule(int column_number)
{
	return this->ruleQueue[column_number].front();
}

RuleList MasterRuleQueue::popRule(int column_number)
{
    RuleList ruleList = this->peekRule(column_number);
    this->ruleQueue[column_number].pop_front();
    return ruleList;
}

Distribution::Distribution()
{
    
}

Distribution::Distribution(map< Entity, int > distribution)
{
	this->distribution = distribution;
}

map< LineGeneratorEntity, int >::iterator Distribution::begin()
{
    return this->distribution.begin();
}

map< LineGeneratorEntity, int >::iterator Distribution::end()
{
    return this->distribution.end();
}

ProbabilityList Distribution::getProbabilityList()
{
	int position = 0;
	ProbabilityList probabilities; 
	for(auto probabilityPair : this->distribution)
	{
		position += probabilityPair.second;
		probabilities.push_back(ProbabilityMapping(probabilityPair.first, position));
	}
	//normalize
	for(auto& probabilityPair : probabilities) probabilityPair.second = (probabilityPair.second / (position)) * 1000;
    return probabilities;
}

void Distribution::removeEntity(Entity entity)
{
	map< Entity, int > newDistribution;
	for(auto& probabilityPair : this->distribution)
	{
		if(&probabilityPair.first != &entity) newDistribution[probabilityPair.first] = probabilityPair.second;
	}
	this->distribution = newDistribution;
}

LineGenerator::LineGenerator()
{
    srand(time(0));
}

LineGenerator::LineGenerator(int width)
{
	this->width = width;
    srand(time(0));
}

void LineGenerator::setDistribution(Distribution distribution)
{
	this->globalDistribution = distribution;
}

Distribution LineGenerator::getDistribution()
{
	return this->globalDistribution;
}

char LineGenerator::generateEntity(Distribution distribution)
{
	int randomNumber = (rand() % 1000);
	char entityToGenerate = Air;
	for(ProbabilityMapping probabilityPair : distribution){
		if(randomNumber < probabilityPair.second) entityToGenerate = probabilityPair.first.getSymbol();
		else break;
	}
	return entityToGenerate;
}

char* LineGenerator::getNextLine()
{
	/*
	rules = ruleQueue.getRule(col_num)
	if(rules.getForceGenerate() == null)
    	evaluatedDist = evaluateDistribution(rules.getExclusions(), col_num)
    	entity = generateEntity(evaluatedDistribution)
	else
    	entity = rules.getForceGenerate()
	bool canPlace = true
	for(rule : entity.getRules())
		if(!ruleQueue.canPlace(rule.getEntity()))
    		canPlace = false
	if(canPlace)
        for(rule in entity.getRules())
        	ruleQueue.addRule(rule.getEntity())
    	generatedLine.addEntity(entity)
	else
    	generatedLine.addEntity(Air)
	++col_num
	*/
    
    /*
    string generatedLine;
	for(int column_number = 0; column_number < this->width; ++column_number)
	{
		RuleList rules = this->masterRuleQueue.popRule(column_number);
        Entity entity;
		if(rules.getForceGenerate().size() < 1){
			Distribution evaluatedDistribution = evaluateDistribution(rules.getExclusions(), column_number);
			entity = this->generateEntity(evaluatedDistribution);
		}
		else entity = rules.getForceGenerate().front().getEntity();
		bool canPlace = true;
		for(Rule rule : entity.getRules())
		{
			if(!this->masterRuleQueue.canPlace(rule.getEntity())){
				canPlace = false;
				break;
			}
		}
        //needs current position
		if(canPlace){
			for(Rule rule : entity.getRules()) this->masterRuleQueue.addRule(rule);
			generatedLine += entity;
		}
		else generatedLine += Air;
	}
     */
    return "yay";
}

