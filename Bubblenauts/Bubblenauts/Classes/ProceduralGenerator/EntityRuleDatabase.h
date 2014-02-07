//
//  EntityRuleDatabase.h
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/6/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#ifndef __Bubblenauts__EntityRuleDatabase__
#define __Bubblenauts__EntityRuleDatabase__

#include <iostream>
#include "Rule.h"
#include "LineGeneratorEntity.h"

namespace ProceduralGenerator
{
    class EntityRuleMapping
    {
    public:
        EntityRuleMapping(Entity entity, ProceduralGenerator::Rule rule);
        EntityRuleMapping(Entity entity, Rules rules);
        Entity getEntity();
        void setEntity(Entity entity);
        Rules getRules();
        void setRules(Rules rules);
        void addRule(ProceduralGenerator::Rule rule);
        Rules getForceGenerate();
        Rules getExclusions();
    private:
        Entity entity;
        Rules rules;
    };
    
    class RelationshipDatabase
    {
    public:
        bool addRule(char entity, ProceduralGenerator::Rule rule);
        bool addRelationship(Entity entity, ProceduralGenerator::Rule rule);
        bool addEntity(Entity entity);
    private:
        std::list<ProceduralGenerator::EntityRuleMapping> database;
    };
}
#endif /* defined(__Bubblenauts__EntityRuleDatabase__) */
