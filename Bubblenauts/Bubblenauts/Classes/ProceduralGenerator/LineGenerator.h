#include "LineGeneratorEntity.h"
#include "Rule.h"
#include <deque>

#define Entity ProceduralGenerator::LineGeneratorEntity
#define ProbabilityList std::list< std::pair<int, ProceduralGenerator::LineGeneratorEntity> >

namespace ProceduralGenerator
{
	class RuleList
	{
	public:
		Rules getExclusions();
		Rules getForceGenerate();
        std::deque<Rule> getRules();

	private:
        std::deque<Rule> rules;
	};

	class RuleQueue
	{
	public:
        ProceduralGenerator::Rule peekRule(int column_number);
		void popRule(int column_number);
		ProceduralGenerator::Rule addRule(ProceduralGenerator::Rule rule, int column_number);
		void addRule(ProceduralGenerator::Rule rule, int row_number, int column_number);
	private:
        std::vector< ProceduralGenerator::RuleList > ruleQueue;
	};

	class Distribution
	{
	public:
		Distribution(std::map< ProceduralGenerator::LineGeneratorEntity, int > distribution);
        Distribution();
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
		char generateEntity(ProbabilityList probabilities);
		char* getNextLine();
		ProceduralGenerator::Distribution evaluateDistribution(Rules exclusions, int column_number);
		void setDistribution(ProceduralGenerator::Distribution);
		ProceduralGenerator::Distribution getDistribution();

	private:
		ProceduralGenerator::Distribution globalDistribution;
		RuleQueue ruleQueue;
		int width;

	};
}