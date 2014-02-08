#ifndef LINEGENERATORENTITY_H
#define LINEGENERATORENTITY_H

#include "Rule.h"
#include <list>
/*
LineGeneratorEntity:
        	symbol: char
        	exclusions: list<Rule>
        	forceGeneration: list<Rule>
        	dimensions: (int, int)
        	scale_factors: (float, float)
        	frequency: int
        	Rules getRules()
*/


namespace ProceduralGenerator{
    
    typedef std::list< ProceduralGenerator::Rule > Rules;
    typedef std::pair<double, double> Double_Pair;
    typedef std::list< Double_Pair > ScaleFactors;
    typedef std::list<ProceduralGenerator::Rule*> RulePointerList;
    
	class LineGeneratorEntity{
	public:
        LineGeneratorEntity();
        LineGeneratorEntity(char symbol);
        LineGeneratorEntity(char symbol, int frequency);
        LineGeneratorEntity(char symbol, int frequency, Integer_Pair dimensions, ScaleFactors scaleFactors);
        LineGeneratorEntity(char symbol, int frequency, Integer_Pair dimensions, ScaleFactors scaleFactors, Rules exclusions, Rules forceGenerate);
		RulePointerList getRules();
        void addExclusion(ProceduralGenerator::Rule rule);
        Rules getExclusions();
        void addForceGeneration(ProceduralGenerator::Rule rule);
        Rules getForceGeneration();
        void setFrequency(int);
		Integer_Pair getDimensions();
		void setDimensions(int x, int y);
		ScaleFactors getScaleFactors();
		void setScaleFactors(ScaleFactors scaleFactors);
        void addScaleFactors(double x, double y);
		char getSymbol();
        bool operator==(const LineGeneratorEntity& rhs);
        bool operator==(const char& rhs);
        bool operator<(const LineGeneratorEntity& rhs) const;
        bool operator<=(const LineGeneratorEntity& rhs);
        bool operator!=(const LineGeneratorEntity& rhs);
	private:
		Rules exclusions;
		Rules forceGeneration;
		Integer_Pair dimensions;
		ScaleFactors scaleFactors;
		int frequency;
        char symbol;
	};
    typedef ProceduralGenerator::LineGeneratorEntity Entity;
}

#endif