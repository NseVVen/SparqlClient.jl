# Include required modules
include("Sparql_logger.jl")
include("SparqlClient.jl")

# Use logger and SPARQL client from included modules
using .SparqlLogger
using .SparqlClient

# Enable logging for debugging purposes
enable_logging()
log_info("Starting CONSTRUCT query test")

# Create a new session targeting the DBpedia SPARQL endpoint
session = SparqlClientSession("https://dbpedia.org/sparql")

# Define a SPARQL CONSTRUCT query to retrieve triples for a specific resource
set_query(session, """
CONSTRUCT {
  <http://dbpedia.org/resource/Asturias> ?p ?o
} WHERE {
  <http://dbpedia.org/resource/Asturias> ?p ?o
} LIMIT 5
""")

# Set query type and return format (RDF/XML)
set_query_type(session, :construct)
set_return_format(session, :xml)

# Execute the query
log_info("Sending CONSTRUCT query...")
xml = query_and_convert(session)
log_info("Received CONSTRUCT response")

# Parse XML response into a list of triples
triples = parse_rdf_triples(xml)

# Print each triple to the console
println("Parsed CONSTRUCT Triples:")
for t in triples
    println("Predicate: $(t.predicate) => Object: $(t.object)")
end
log_info("Printed all CONSTRUCT triples")

# Save raw RDF/XML to a file
save_rdf_xml(xml, "construct_result.rdf")
