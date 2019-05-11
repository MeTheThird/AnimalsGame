/*
* Rohan Thakur
* Date Created: 3/25/19
* An Expert System that plays the Think of an Animal Game, capping it at 20 questions asked by the
* system.
*/

(clear)
(reset)

(batch utilities_v2.clp)

(defglobal ?*numOfQuestions* = 0) ; the number of questions asked by the system so far

/*
* the list of attributes for dynamically creating all of their backward-chaining rules
*/
(defglobal ?*listOfAttributes* = (list landBased
                                       endotherm
                                       mammal
                                       smallerThanHuman
                                       farmAnimal
                                       multicolored
                                       endemicToAfrica
                                       canine
                                       producesMilk
                                       fly
                                       riddenCommercially
                                       ocean
                                       goesOnLand
                                       seaFloor
                                       haveFur
                                       liveInTrees
                                       shelled
                                       haveMane
                                       feline
                                       commonlyEaten))

/*
* the corresponding list of questions to ask the user for dynamically creating each attribute's
* backward-chaining rule
*
* in this list, the attribute located at index i in listOfAttributes is also at index i in
* listOfQuestions
*/
(defglobal ?*listOfQuestions* = (list "Is your animal exclusively land-based (it does not spend a sizable amount of time in the water nor does it fly)? "
                                      "Is your animal warm-blooded? "
                                      "Is your animal a mammal? "
                                      "As an adult, is your animal smaller than an average adult human? "
                                      "Is your animal a farm animal (dogs, pigs, cows, etc.)? "
                                      "Is your animal multicolored? "
                                      "Is your animal endemic to Africa? "
                                      "Is your animal canine? "
                                      "Do humans profit off of your animal's producing milk? "
                                      "Can your animal fly? "
                                      "Can your animal be ridden commercially? "
                                      "Does your animal reside in or often interact with the ocean? "
                                      "Is your animal often on land? "
                                      "Does your animal reside on the sea floor? "
                                      "Does your animal have fur? "
                                      "Does your animal live in trees? "
                                      "Does your animal have a shell? "
                                      "Does your animal have a mane? "
                                      "Is your animal feline? "
                                      "Is your animal commonly eaten? "))

/*
* dynamically creates all of the do-backward-chaining commands by iterating through listOfAttributes
*/
(for (bind ?i 1) (<= ?i (length$ ?*listOfAttributes*)) (++ ?i)
   (build (str-cat "(do-backward-chaining " (nth$ ?i ?*listOfAttributes*) ")"))
)

(do-backward-chaining legs) ; since legs isn't in listOfAttributes, this ensures that it is also
                            ; backward chained

(defrule startup "sets up the think of an animal game"
   (declare (salience 100))
=>
   (printline "Let's play 20 questions! Answer the questions with y, n, or ? after you choose an animal from the following: dog, chicken, bee, camel, zebra, elephant, pig, cow, dolphin, sea lion, hippo, hermit crab, bear, ant, monkey, crow, tortoise, lion, shrimp, cat.")
   (printline "")
)

(defrule dog-rule "Rule to determine whether the chosen animal is a dog"
   (landBased "y")
   (endotherm "y")
   (mammal "y")
   (legs 4)
   (smallerThanHuman ?ans)
   (test (or (eq ?ans "y") (eq ?ans "?"))) ; some people may not know if dogs are smaller than
                                           ; humans or not
   (farmAnimal "y")
   (canine "y")
=>
   (printSolution "dog")
)

(defrule chicken-rule "Rule to determine whether the chosen animal is a chicken"
   (landBased "y")
   (endotherm "y")
   (mammal "n")
   (legs 2)
   (smallerThanHuman "y")
   (farmAnimal "y")
=>
   (printSolution "chicken")
)

(defrule bee-rule "Rule to determine whether the chosen animal is a bee"
   (landBased "n")
   (endotherm ?ans)
   (test (or (eq ?ans "n") (eq ?ans "?"))) ; some people may not know if bees are endotherms or not
   (fly "y")
   (mammal "n")
   (legs 6)
   (multicolored "y")
=>
   (printSolution "bee")
)

(defrule camel-rule "Rule to determine whether the chosen animal is a bee"
   (landBased "y")
   (endotherm "y")
   (mammal "y")
   (legs 4)
   (smallerThanHuman "n")
   (endemicToAfrica "y")
   (multicolored "n")
=>
   (printSolution "camel")
)

(defrule zebra-rule "Rule to determine whether the chosen animal is a zebra"
   (landBased "y")
   (endotherm "y")
   (mammal "y")
   (legs 4)
   (smallerThanHuman ?ans)
   (test (or (eq ?ans "n") (eq ?ans "?"))) ; some people may not know if zebras are smaller than
                                           ; humans or not
   (endemicToAfrica "y")
   (multicolored "y")
=>
   (printSolution "zebra")
)

(defrule elephant-rule "Rule to determine whether the chosen animal is an elephant"
   (landBased "y")
   (endotherm "y")
   (mammal "y")
   (legs 4)
   (smallerThanHuman "n")
   (endemicToAfrica "y")
   (multicolored "n")
   (riddenCommercially "y")
=>
   (printSolution "elephant")
)

(defrule pig-rule "Rule to determine whether the chosen animal is a pig"
   (landBased "y")
   (endotherm "y")
   (mammal "y")
   (legs 4)
   (smallerThanHuman "y")
   (farmAnimal "y")
   (canine "n")
=>
   (printSolution "pig")
)

(defrule cow-rule "Rule to determine whether the chosen animal is a cow"
   (landBased "y")
   (endotherm "y")
   (mammal "y")
   (legs 4)
   (smallerThanHuman "n")
   (farmAnimal "y")
   (producesMilk "y")
=>
   (printSolution "cow")
)

(defrule dolphin-rule "Rule to determine whether the chosen animal is a dolphin"
   (landBased "n")
   (endotherm "y")
   (ocean "y")
   (mammal "y")
   (legs 0)
   (riddenCommercially "y")
=>
   (printSolution "dolphin")
)

(defrule seaLion-rule "Rule to determine whether the chosen animal is a sea lion"
   (landBased "n")
   (endotherm "y")
   (ocean "y")
   (mammal "y")
   (legs 0)
   (goesOnLand "y")
=>
   (printSolution "sea lion")
)

(defrule hippo-rule "Rule to determine whether the chosen animal is a hippo"
   (landBased ?ans)
   (test (or (eq ?ans "n") (eq ?ans "?"))) ; some people may not know if hippos are exclusively land
                                           ; based or not
   (endotherm "y")
   (mammal "y")
   (legs 4)
   (endemicToAfrica "y")
   (goesOnLand "y")
=>
   (printSolution "hippo")
)

(defrule hermitCrab-rule "Rule to determine whether the chosen animal is a hermit crab"
   (landBased "n")
   (endotherm "n")
   (ocean "y")
   (mammal "n")
   (shelled "y")
   (seaFloor "y")
   (commonlyEaten "n")
=>
   (printSolution "hermit crab")
)

(defrule wolf-rule "Rule to determine whether the chosen animal is a wolf"
   (landBased "y")
   (endotherm "y")
   (mammal "y")
   (legs 4)
   (farmAnimal "n")
   (canine "y")
=>
   (printSolution "wolf")
)

(defrule bear-rule "Rule to determine whether the chosen animal is a bear"
   (landBased "n")
   (endotherm "y")
   (mammal "y")
   (legs ?ans)
   (test (or (eq ?ans 2) (eq ?ans 4))) ; some people may not know whether bears have 2 or 4 legs
   (smallerThanHuman "n")
   (haveFur "y")
=>
   (printSolution "bear")
)

(defrule ant-rule "Rule to determine whether the chosen animal is an ant"
   (landBased "y")
   (endotherm ?ans)
   (test (or (eq ?ans "n") (eq ?ans "?"))) ; some people may not know if bees are endotherms or not
   (mammal "n")
   (legs 6)
   (smallerThanHuman "y")
=>
   (printSolution "ant")
)

(defrule monkey-rule "Rule to determine whether the chosen animal is a monkey"
   (landBased "y")
   (endotherm "y")
   (mammal "y")
   (legs ?ans)
   (test (or (eq ?ans 2) (eq ?ans 4))) ; some people may not know if monkeys normally walk on 2 or 4
                                       ; legs
   (smallerThanHuman "y")
   (endemicToAfrica "y")
   (liveInTrees "y")
=>
   (printSolution "monkey")
)

(defrule crow-rule "Rule to determine whether the chosen animal is a crow"
   (landBased "n")
   (endotherm "y")
   (fly "y")
   (mammal "n")
   (legs 2)
   (smallerThanHuman "y")
   (multicolored "n")
=>
   (printSolution "crow")
)

(defrule armadillo-rule "Rule to determine whether the chosen animal is an armadillo"
   (landBased "y")
   (endotherm "y")
   (mammal "y")
   (legs 4)
   (smallerThanHuman "y")
   (shelled "y")
=>
   (printSolution "armadillo")
)

(defrule tortoise-rule "Rule to determine whether the chosen animal is a tortoise"
   (landBased "n")
   (endotherm "n")
   (mammal "n")
   (legs 4)
   (smallerThanHuman "y")
   (goesOnLand "y")
   (shelled "y")
=>
   (printSolution "tortoise")
)

(defrule lion-rule "Rule to determine whether the chosen animal is a lion"
   (landBased "y")
   (endotherm "y")
   (mammal "y")
   (legs 4)
   (smallerThanHuman "n")
   (endemicToAfrica "y")
   (haveMane "y")
=>
   (printSolution "lion")
)

(defrule shrimp-rule "Rule to determine whether the chosen animal is a shrimp"
   (landBased "n")
   (endotherm "n")
   (ocean "y")
   (mammal "n")
   (smallerThanHuman "y")
   (shelled "y")
   (seaFloor "y")
   (commonlyEaten "y")
=>
   (printSolution "shrimp")
)

(defrule cat-rule "Rule to determine whether the chosen animal is a cat"
   (landBased "y")
   (endotherm "y")
   (mammal "y")
   (legs 4)
   (smallerThanHuman "y")
   (feline "y")
=>
   (printSolution "cat")
)

/*
* dynamically creates all the backward-chaining rules except for the legs one because the legs rule
* requires inference, so it doesn't conform to the same structure well
*
* this loop does the above by iterating through the list of attribute names and questions,
* dynamically creating the corresponding backward-chaining rule at every iteration
*
* SAMPLE CODE:
* (defrule endothermBackward
*    (need-endotherm ?)
* =>
*    (++ ?*numOfQuestions*)
*    (bind ?ans (lowCaseFirstChar (ask (str-cat "#" ?*numOfQuestions* ": " "Is the animal warm-blooded? "))))
*    (if (isValidQuestionAnswer ?ans) then
*       (assert (endotherm ?ans))
*     else
*        (chastiseTheUser)
*    )
* )
*/
(for (bind ?i 1) (<= ?i (length$ ?*listOfAttributes*)) (++ ?i)
   (bind ?currentAttribute (nth$ ?i ?*listOfAttributes*)) ; the current attribute to create the
                                                          ; backward-chaining rule for
   (bind ?currentQuestion (nth$ ?i ?*listOfQuestions*)) ; the corresponding question to ask the user

   /*
   * begins setting up ruleString with the defrule command and the name of the rule to be created
   */
   (bind ?ruleString (str-cat "(defrule " ?currentAttribute "Backward "))

   /*
   * sets up the LHS of the rule by adding the need indicator
   */
   (bind ?ruleString (str-cat ?ruleString "(need-" ?currentAttribute " ?) => "))

   /*
   * sets up the RHS of the rule, the main purpose of which is to ask the user a question and assert
   * the user's answer
   */
   (bind ?ruleString (str-cat ?ruleString "(++ ?*numOfQuestions*)
                              (if (> ?*numOfQuestions* 20) then
                                 (printline \"I couldn't guess your animal in 20 questions :\(\")
                                 (halt)
                               else
                                  (bind ?ans (lowCaseFirstChar (ask (str-cat \"#\" ?*numOfQuestions*"
                                 " \": \" \"" ?currentQuestion "\"))))
                                 (if (isValidQuestionAnswer ?ans) then
                                    (assert (" ?currentAttribute " ?ans))
                                  else
                                     (chastiseTheUser)
                                 )))"))

   (build ?ruleString)
) ; for (bind ?i 1) (<= ?i (length$ ?*listOfAttributes*)) (++ ?i)

(defrule legsBackward "Rule to backward-chain how many legs the animal has by asking the user a
                       series of questions and drawing a conclusion based on the user's answers
                       and the possible animals that the user can choose"
   (need-legs ?)
=>
   (++ ?*numOfQuestions*)
   (bind ?ans (lowCaseFirstChar (ask (str-cat "#" ?*numOfQuestions*
                                      ": Does your animal usually walk on 4 legs/limbs (flippers don't count)? "))))

   (if (isValidQuestionAnswer ?ans) then
      (if (eq ?ans "y") then
         (bind ?ans 4) ; the animal has 4 legs
       else
          (++ ?*numOfQuestions*)
          (bind ?ans (lowCaseFirstChar (ask (str-cat "#" ?*numOfQuestions*
                                             ": Does your animal usually walk on less than 4 legs/limbs (flippers don't count)? "))))
          (if (isValidQuestionAnswer ?ans) then
             (if (eq ?ans "y") then
                (++ ?*numOfQuestions*)
                (bind ?ans (lowCaseFirstChar (ask (str-cat "#" ?*numOfQuestions*
                                                   ": Does your animal usually walk on 2 legs/limbs (flippers don't count)? "))))
                (if (isValidQuestionAnswer ?ans) then
                   (if (eq ?ans "y") then
                      (bind ?ans 2) ; the animal has 2 legs
                    else
                       (bind ?ans 0) ; the animal must have 0 legs if it has less than 4 and not 2 legs
                   )
                 else
                    (chastiseTheUser)
                ) ; if (isValidQuestionAnswer ?ans)
              else
                 (bind ?ans 6) ; it can be asserted that the animal has 6 legs if it has more than 4
                               ; because either it does or this line of questioning is not useful
                               ; and there are other factors to differentiate the animal from others
             ) ; if (eq ?ans "y")
           else
              (chastiseTheUser)
          ) ; if (isValidQuestionAnswer ?ans)
      ) ; if (eq ?ans "y")

      (assert (legs ?ans))
    else
       (chastiseTheUser)
   ) ; if (isValidQuestionAnswer ?ans)
)

/*
* returns the first character of a string
*/
(deffunction lowCaseFirstChar (?str)
   (return (lowcase (sub-string 1 1 ?str)))
)

/*
* returns true if the input is either "y", "n", or "?", regardless of case; returns false otherwise
*/
(deffunction isValidQuestionAnswer (?str)
   (bind ?str (lowcase ?str))

   (return (or (eq ?str "y") (or (eq ?str "n") (eq ?str "?"))))
)

/*
* scolds the user for not entering a valid answer
*/
(deffunction chastiseTheUser ()
   (printline "")
   (printline "Please enter something that begins with y, n, or ?")
   (halt)
)

/*
* prints out what the system thinks the user's animal is and ends the game
*/
(deffunction printSolution (?animalName)
   (printline (str-cat "Your animal must be a(n) " ?animalName "."))
   (halt)
)

(run) ; begins the game of 20 questions
