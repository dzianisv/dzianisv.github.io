https://learn.deeplearning.ai/chatgpt-prompt-eng/lesson/2/guidelines

Base LLM: Once upon a time there was a unicorn that live in a magical world.

Instruction Tuned LLM. Uses Reinforment Learning Human Feedback. Helpful. Honest. Harmless. For instance: Whait is the capita? The capital of France is Paris.

Give instruction that a smart enough but don't know specific of your task.


The nice thing that this course is interactive and you can play with ChatGPT on the course webpage

![](img/2023-09-17-23-23-11.webp)

# Principles
## Princeple 1: Write clear and specific instructions

1. Write the clear and specific instructions
""", ```, ---, <>, <tag></tag>
> Fix mistakes and rewrite text delimited by triple backticks into a generic cover latter for Software Engineer

2. Ask for structured output
HTML, JSON
> Generate a list of three made-up book titles along with their authors and genres.  Provide them in JSON format with the following keys:  book_id, title, author, genre.

3. Ask the model to check whether conditions are satisfied
Check assumptions required to do the task

> You will be provided with text delimited by triple quotes.
> If it contains a sequence of instructions, \
> re-write those instructions in the following format:
> Step 1 - ...
> Step 2 - …
> …
> Step N - …
> If the text does not contain a sequence of instructions, \
> then simply write \"No steps provided.\"

4. "Few-shot" prompting
Give succesfsful examples of compteling tasks
Then ask model to perfom the task

> Your task is to answer in a consistent style.
> <child>: Teach me about patience.
> <grandparent>: The river that carves the deepest \
> valley flows from a modest spring; the \
> grandest symphony originates from a single note; \
> the most intricate tapestry begins with a solitary thread.
> <child>: Teach me about resilience.

## Principle 2: Give the model time to think

1. Specify the steps to complete the task
> Your task is to perform the following actions:
> 1 - Summarize the following text delimited by
>  <> with 1 sentence.
> 2 - Translate the summary into French.
> 3 - List each name in the French summary.
> 4 - Output a json object that contains the
>  following keys: french_summary, num_names.
> Use the following format:
> Text: <text to summarize>
> Summary: <summary>
> Translation: <summary translation>
> Names: <list of names in Italian summary>
> Output JSON: <json with summary and num_names>
>
> Text: <{text}>

2. Instruct the model to work out its own solution before rushing to a conclusion¶

> Your task is to determine if the student's solution \
> is correct or not.
> To solve the problem do the following:
> - First, work out your own solution to the problem.
> - Then compare your solution to the student's solution \
> and evaluate if the student's solution is correct or not.
> Don't decide if the student's solution is correct until
> you have done the problem yourself.


## Model Limitations

- Hallucination
``` python
prompt = f"""
Tell me about AeroGlide UltraSlim Smart Toothbrush by Boie
"""
response = get_completion(prompt)
print(response)
prompt = f"""
Tell me about AeroGlide UltraSlim Smart Toothbrush by Boie
"""
response = get_completion(prompt)
print(response)
```

> The AeroGlide UltraSlim Smart Toothbrush by Boie is a technologically advanced toothbrush designed to provide a superior brushing experience. Boie is a company known for its innovative oral care products, and the AeroGlide UltraSlim Smart Toothbrush is no exception.

How to reduce hallucinations:
1. Find relevant information
2. Answer the question absed on the relevan information.


- Make setatement that sound plausible but are not true

# Interactive Prompt Development

- Try something
- Analyze where the result does not give what you want
- Clarify instructions, give more time to think
- Refine prompts with a batch of examples
