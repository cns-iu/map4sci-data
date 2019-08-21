

--Paper references Patent
CALL apoc.export.csv.query('MATCH(n:paper{doc_type:""})-[:REFERENCES]->(m:paper)
WHERE n.doi IS NOT NULL AND n.doi <> "" AND m.doi <> "" AND m.doc_type = "Patent"
RETURN n.doc_type, n.paper_id, n.doi, m.doc_type, m.paper_id, m.doi', 'paper_to_patent_MAG.csv', {});


--Patent references Paper
CALL apoc.export.csv.query('MATCH(n:paper{doc_type:"Patent"})-[:REFERENCES]->(m:paper)
WHERE n.doi IS NOT NULL AND n.doi <> "" AND m.doi <> "" AND m.doc_type = ""
RETURN n.doc_type, n.paper_id, n.doi, m.doc_type, m.paper_id, m.doi', 'patent_to_paper_MAG.csv', {});

--Paper references Patent - No DOI
CALL apoc.export.csv.query('MATCH(n:paper{doc_type:""})-[:REFERENCES]->(m:paper)
WHERE  m.doc_type = "Patent"
RETURN n.doc_type, n.paper_id, n.display_title, m.doc_type, m.paper_id, m.display_title', 'No_DOI_paper_to_patent_MAG.csv', {});


--Patent references Paper - No DOI
CALL apoc.export.csv.query('MATCH(n:paper{doc_type:"Patent"})-[:REFERENCES]->(m:paper)
WHERE  m.doc_type = ""
RETURN n.doc_type, n.paper_id, n.display_title, m.doc_type, m.paper_id, m.display_title', 'No_DOI_patent_to_paper_MAG.csv', {});
