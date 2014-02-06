#include "LineGeneratorEntity.h"
#include "Rule.h"
#include <deque>


namespace ProceduralGenerator
{
    typedef ProceduralGenerator::LineGeneratorEntity Entity;
    typedef std::pair<Entity, int> ProbabilityMapping;
    typedef std::list<ProbabilityMapping> ProbabilityList;
    
	class RuleList
	{
	public:
		Rules getExclusions();
		Rules getForceGenerate();
        int size();
        std::list<Rule> getRules();

	private:
        std::list<Rule> rules;
	};
    
    typedef std::deque<ProceduralGenerator::RuleList> RuleQueue;

	class MasterRuleQueue
	{
	public:
        ProceduralGenerator::RuleList peekRule(int column_number);
		ProceduralGenerator::RuleList popRule(int column_number);
        int size();
        int size(int index);
		void addRule(ProceduralGenerator::Rule rule, int column_number, int height);
	private:
        std::vector< RuleQueue > ruleQueue;
	};

	class Distribution
	{
	public:
		Distribution(std::map< ProceduralGenerator::LineGeneratorEntity, int > distribution);
        Distribution();
        std::map< ProceduralGenerator::LineGeneratorEntity, int >::iterator begin();
        std::map< ProceduralGenerator::LineGeneratorEntity, int >::iterator end();
		ProbabilityList getProbabilityList();
		void removeEntity(Entity entity);
	private:
		std::map< ProceduralGenerator::LineGeneratorEntity,  int > distribution;

	};

	class LineGenerator
	{
	public:
        LineGenerator();
		LineGenerator(int);
		char generateEntity(ProceduralGenerator::Distribution distribution);
		char* getNextLine();
		ProceduralGenerator::Distribution evaluateDistribution(Rules exclusions, int column_number);
		void setDistribution(ProceduralGenerator::Distribution);
		ProceduralGenerator::Distribution getDistribution();

	private:
		ProceduralGenerator::Distribution globalDistribution;
		MasterRuleQueue masterRuleQueue;
		int width;

	};
}