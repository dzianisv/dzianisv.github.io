# LangChain

[Course](https://learn.deeplearning.ai/langchain/lesson/2/models,-prompts-and-parsers)


```python
from langchain.chat_models import ChatOpenAI
from langchain.prompts import ChatPromtTemplate
from langchain.output_parser import ResnseSchema, StructuredOutputParser

chat = ChatOpenAI(temperature=0.0)

template_string = f"Translate thi text that is delimited by <<< >>> into a style that is {style}. text <<<{text}>>>"
review_template_2 = """\
For the following text, extract the following information:

{format_instructions}

text: {text}
"""
"
gift_schema = ResponseSchema(name="gift",
                             description="Was the item purchased\
                             as a gift for someone else? \
                             Answer True if yes,\
                             False if not or unknown.")

delivery_days_schema = ResponseSchema(name="delivery_days",
                                      description="How many days\
                                      did it take for the product\
                                      to arrive? If this \
                                      information is not found,\
                                      output -1.")
price_value_schema = ResponseSchema(name="price_value",
                                    description="Extract any\
                                    sentences about the value or \
                                    price, and output them as a \
                                    comma separated Python list.")

response_schemas = [gift_schema,
                    delivery_days_schema,
                    price_value_schema]

output_parser = StructuredOutputParser.from_response_schemas(response_schemas)
format_instructions = output_parser.get_format_instructions()

prompt = ChatPromptTEmplate.from_template()
output_dict = output_parser.parse(response.content)


prompt = ChatPromptTemplate.from_template(template=review_template)
messages = prompt.format_messages(text=customer_review, format_instructions=format_instructions)
response = chat(messages)
output_dict = output_parser.parse(response.content)
```

## Reasons to use LangChain:

- Prompts can be long and detailed.
- Reuse good promts when you can.
- LangChain also provides prompts for common operations.



# Memory

- `ConversationBufferMemory()`
- `ConversationBufferWindowMemory(k=1)`
- `ConversationTokenBufferMemory(llm=llm, max_token_limit=30)`
- `ConversationSummaryBufferMemory(llm=llm, max_token_limit=100)`


## How to use
```python
llm = ChatOpenAI(temperature=0.0, model=llm_model)
memory = ConversationBufferMemory()
conversation = ConversationChain(
    llm=llm,
    memory = memory,
    verbose=True
)
```