"""added classrooms

Revision ID: 4c6e055b0974
Revises: ddd382bb4852
Create Date: 2023-09-02 15:44:47.345753

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '4c6e055b0974'
down_revision = 'ddd382bb4852'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('class', schema=None) as batch_op:
        batch_op.add_column(sa.Column('classroom', sa.String(length=20), nullable=True))

    with op.batch_alter_table('classes_people', schema=None) as batch_op:
        batch_op.alter_column('user_id',
               existing_type=sa.INTEGER(),
               nullable=True)
        batch_op.alter_column('class_id',
               existing_type=sa.INTEGER(),
               nullable=True)
        batch_op.drop_index('class_pupil')
        batch_op.drop_index('pupils')

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('classes_people', schema=None) as batch_op:
        batch_op.create_index('pupils', ['class_id', 'user_id'], unique=False)
        batch_op.create_index('class_pupil', ['class_id', 'user_id'], unique=False)
        batch_op.alter_column('class_id',
               existing_type=sa.INTEGER(),
               nullable=False)
        batch_op.alter_column('user_id',
               existing_type=sa.INTEGER(),
               nullable=False)

    with op.batch_alter_table('class', schema=None) as batch_op:
        batch_op.drop_column('classroom')

    # ### end Alembic commands ###