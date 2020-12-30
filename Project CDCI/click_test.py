from click.testing import CliRunner
from Click import hello 

def test_hello():
    runner=CliRunner()
    result=runner.invoke(hello,["--name", "Ashraf", "--color", "blue"])
    assert "Ashraf" in result.output

