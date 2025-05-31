# Include necessary modules
include("Sparql_logger.jl")
include("SparqlClient.jl")

# Import logging and SPARQL client functionalities
using .SparqlLogger
using .SparqlClient

# Enable logging for debugging and traceability
enable_logging()
log_info("Starting ASK query test")

# Create a new SPARQL client session for the DBpedia endpoint
session = SparqlClientSession("https://dbpedia.org/sparql")

# Set up an ASK query to check if the resource is a dbo:Place
set_query(session, """
ASK {
  <http://dbpedia.org/resource/Asturias> a dbo:Place
}
""")

# Specify query type and desired return format
set_query_type(session, :ask)
set_return_format(session, :json)

# Execute the query
log_info("Sending ASK query...")
println("ASK query result:")
result = query_and_convert(session)

# Log and print the boolean result
log_info("Received ASK response: $(result)")
println(result ? "Yes" : "No")

# Save the result to a text file
save_ask_result(result, "ask_result.txt")
