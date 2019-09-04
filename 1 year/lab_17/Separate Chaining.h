//
// Created by aso on 3/29/19.
//

#ifndef LAB_17_SEPARATE_CHAINING_H
#define LAB_17_SEPARATE_CHAINING_H
struct node{
    int data;
    node *next = nullptr;
};

node **create_table();
void add(int data, node**table);
node *search(int data, node**table);
void clear(node **table);
int s_chain();


#endif //LAB_17_SEPARATE_CHAINING_H
