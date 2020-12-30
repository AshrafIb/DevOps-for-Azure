import click 

@click.command(help='This is just a hello app. Id does Nothing')
@click.option("--name",prompt="In need your name", help='Need Name')
@click.option("--color",prompt="I need your color", help="This is your color")

def hello(name, color):
    if name=="Thor":
        click.echo("Thor your are always red")
        click.echo(click.style("Hello World! {}".format(name), fg='red'))
    else:
        click.echo("{}, your color is {}".format(name,color))
        click.echo(click.style("Hello {}".format(name),fg=color))
        
if __name__ == '__main__':
    hello()
