# Include required source files
include("Sparql_logger.jl")
include("SparqlClient.jl")

# Import logger and SPARQL client modules
using .SparqlLogger
using .SparqlClient

# Enable logging to track execution
enable_logging()
log_info("Starting DESCRIBE query test")

# Create a SPARQL session targeting DBpedia endpoint
session = SparqlClientSession("https://dbpedia.org/sparql")

# Set DESCRIBE query for a specific resource
set_query(session, "DESCRIBE <http://dbpedia.org/resource/Asturias>")

# Specify query type and return format (RDF/XML)
set_query_type(session, :describe)
set_return_format(session, :rdf)

# Execute the query and retrieve the result as an XML document
log_info("Sending DESCRIBE query...")
doc = query_and_convert(session)

# Save the raw RDF/XML response to a file
save_rdf_xml(doc, "describe_result.rdf")

# Parse the RDF/XML into structured RDFTriple objects
triples = extract_rdf_triples(doc)
log_info("Received and parsed DESCRIBE response with $(length(triples)) triples")

# Print extracted RDF triples to the console
println("RDF Triples from DESCRIBE:")
for triple in triples
    println("Subject:   ", triple.subject)
    println("Predicate: ", triple.predicate)
    println("Object:    ", triple.object)
    println()
end

log_info("Printed all DESCRIBE triples")
